#!/usr/bin/env bash
# Diagnose the state of the system Python after a deploy, specifically to find
# what caused `dnf` to stop working (dnf/yum are Python 3.9 apps on AlmaLinux 9
# and link against libpython3.9.so).
#
# Run this on the affected server and share the full output. It intentionally
# uses NO Python to gather facts, because Python itself may be broken.
set -uo pipefail

echo "== Python / dnf state diagnostics =="
echo "Generated: $(date)"
echo

divider() { echo; echo "---------------- $1 ----------------"; }

divider "1. Distro / OS"
cat /etc/os-release 2>/dev/null || echo "os-release unavailable"
echo "uname -r : $(uname -r 2>/dev/null)"

divider "2. dnf / yum / rpm status"
echo "-- where is dnf --"
command -v dnf || echo "dnf NOT on PATH"
echo "-- dnf shebang --"
if command -v dnf >/dev/null 2>&1; then head -n1 "$(command -v dnf)"; fi
if [[ -e /usr/bin/dnf ]]; then head -n1 /usr/bin/dnf; fi
echo "-- dnf exit code (try running 'dnf --version') --"
dnf --version >/tmp/dnf_test.out 2>/tmp/dnf_test.err
echo "exit code: $?"
echo "stdout (first 5 lines):"
head -n5 /tmp/dnf_test.out 2>/dev/null
echo "stderr (all):"
cat /tmp/dnf_test.err 2>/dev/null

divider "3. System python3 (the interpreter dnf depends on)"
for p in /usr/bin/python3 /usr/bin/python3.6 /usr/bin/python3.9 /bin/python3; do
    if [[ -e "$p" ]]; then
        echo "$p -> $(readlink -f "$p" 2>/dev/null || echo "$p")"
    fi
done
echo "-- /usr/bin/python3 --version (does it even run?) --"
/usr/bin/python3 --version 2>&1 | head -n20
echo "exit code: $?"

divider "4. python3 libraries in system locations"
echo "-- /usr/lib64/libpython3* --"
ls -l /usr/lib64/libpython3* 2>/dev/null || echo "none in /usr/lib64"
echo "-- /usr/lib/libpython3* --"
ls -l /usr/lib/libpython3* 2>/dev/null || echo "none in /usr/lib"
echo "-- /usr/local/lib/libpython3* (the compiled one) --"
ls -l /usr/local/lib/libpython3* 2>/dev/null || echo "none in /usr/local/lib"

divider "5. ld.so search path configuration"
echo "-- /etc/ld.so.conf --"
cat /etc/ld.so.conf 2>/dev/null
echo "-- /etc/ld.so.conf.d/*.conf --"
for f in /etc/ld.so.conf.d/*.conf; do
    echo "FILE: $f"
    cat "$f" 2>/dev/null
done
echo "-- files mentioning python under ldconfig config --"
grep -rni python /etc/ld.so.conf /etc/ld.so.conf.d/ 2>/dev/null || echo "(none)"

divider "6. ldconfig cache: which libpython wins"
echo "-- ldconfig -p | grep libpython --"
ldconfig -p 2>/dev/null | grep -i libpython || echo "ldconfig failed or no libpython"

divider "7. What shared lib does /usr/bin/python3 actually load?"
if [[ -x /usr/bin/python3 ]]; then
    ldd /usr/bin/python3 2>&1 | grep -iE 'python|not found|=>' | head -n40
fi

divider "8. What does dnf's python load? (strace not needed; check its deps)"
if [[ -x /usr/bin/dnf ]]; then
    ldd /usr/bin/dnf 2>&1 | grep -iE 'python|not found|=>' | head -n40
fi

divider "9. The compiled python we installed"
echo "-- /usr/local/bin/python3* --"
ls -l /usr/local/bin/python3* 2>/dev/null || echo "none"
echo "-- /usr/local/bin/python3 --version --"
/usr/local/bin/python3 --version 2>&1 | head -n20
echo "-- ldd /usr/local/bin/python3.* (does it find its own lib?) --"
for b in /usr/local/bin/python3.12 /usr/local/bin/python3.11 /usr/local/bin/python3.10 /usr/local/bin/python3; do
    if [[ -x "$b" ]]; then
        echo "$b:"
        ldd "$b" 2>&1 | grep -iE 'python|not found|=>' | head -n20
    fi
done

divider "10. Is /usr/bin/python3 now shadowed?"
echo "PATH = $PATH"
echo "which python3 -> $(command -v python3 || echo 'NOT FOUND')"
echo "which python  -> $(command -v python  || echo 'NOT FOUND')"

divider "11. RPM ownership of system python (what SHOULD be there)"
rpm -q python3 2>/dev/null && echo "python3 rpm installed"
rpm -q platform-python 2>/dev/null && echo "platform-python rpm installed"
echo "-- rpm -ql platform-python (system libpython) --"
rpm -ql platform-python 2>/dev/null | grep -iE 'libpython|bin/python' || echo "(query failed)"

divider "12. Summary hints"
echo "If dnf exits non-zero with a Python ImportError or 'undefined symbol',"
echo "the likely cause is:"
echo "  - /usr/local/lib listed in ld.so.conf.d before /usr/lib64, so our"
echo "    libpython3.12.so shadows the system libpython3.9.so that dnf needs."
echo "  - OR --enable-shared + altinstall overwrote/damaged a system file."
echo
echo "Fix candidates:"
echo "  - sudo rm -f /etc/ld.so.conf.d/python*.conf && sudo ldconfig"
echo "  - OR ensure /usr/local/lib is NOT globally preferred over /usr/lib64."
