![alt text](networkinglinux.jpg "Linux Networking Diagram")

## What is a Network?

A network is defined by an interface, an IP address, a gateway and a subnet mask.

1. E.g. IP address 192.168.1.2
2. Subnet mask: 192.168.\*.\* (/16)
3. Gateway: 192.168.1.1

## What is a NAT?

NAT - network address translation is a type of firewall that rewrites the IP
address of packets sent to the gateway of the machine so they come out from
another interface on the router. And visa versa. So:
```
[LAN 1] <------------> [Router] <------------> [LAN 2] <----> [INTERNET]
            10.1.100.1/24   192.168.1.1/24
```
The router has two IP addresses as it has two interfaces. They are each on
different networks. When it receives a packet from LAN 1 that is not destined
for LAN 1's network, it converts it to LAN 2, and sends it to its gateway on the
internet.

The firewall also rewrites packets on the way back so they appear to be from the
right IP address.

Double-NATed networks can cause problems because you cannot make a direct
connection without the network address translation. Ports have to be forwarded
by the firewall on the router to the right LAN. It is normally fine for outbound
traffic from the NATed LAN, LAN 1, but not for hosting services on LAN 1.
Because the machine on LAN 1 has no fixed IP address bar the gateway on LAN 2.

## What is DNS?

DNS is used to resolve domain names into IP addresses. Your ISP will have a
number of DNS servers you can use, and those are assigned by default. You can
also use public DNS servers, such as Google's DNS 8.8.8.8 or CloudFlare's DNS
1.1.1.1

Public DNS servers won't have any records of your internal network hostnames, so
if you want "davids-computer.davids-network.local" hostnames, then you're going
to have to have a DNS server on your internal network.

DNS servers are easy to setup, a good choice is Pi-Hole which runs on a Raspberry Pi,
and includes a constantly updated list of 'bad' domain names from spammers, malware
etc, so provides some measure of protection.

A local DNS server will forward internet domain names to a public DNS server
such as mentioned before, and it will respond with IP addresses of the local DNS
entries it is setup for.

## What is a routing table?

A routing table entry consists of:

1. Network
2. Gateway
3. Interface IP
4. Routing Weight/Metric

* Network is a subnet mask of a network for example, 192.168.1.\* 24. Any traffic
to IP addresses in that network range will be managed by this routing rule.
* Gateway is the machine on that network to route traffic to that is destined
for that network, e.g. 192.168.1.5
* Interface is the network interface and local IP address for that interface.
* Metric is the 'weighting' traffic is given to favour this routing rule. When
there is more than one option to choose from for routing traffic, then the
smaller number wins. So if you have an IP address accessible via two routes,
and one has a metric of 1 and the other 2, then 1 will be chosen first, unless
metric 1's interface is down.

It also specifies a 'default route' which is identifiable as a Network of a
subnet mask of '0.0.0.0' on the interface. It will have the lowest metric.
This is the route which is used for any traffic not destined for any of the networks
in the routing table. There will be a gateway specified which is typically another
router with its own routing table. That other router will have a default route..
and so on.

This is how traffic is handled on the internet, through routers passing on the
traffic to their default route until there is a relevant entry in the routing table,
or the maximum number of hops is reached.

## Traceroute

To trace the life of a connection, you can use the network tool traceroute to
connect to a particular IP address. It will map out the routers and routing tables
that your connection goes through before it arrives at its destination.

You can use this tool on different IP addresses to make sure your routing table
is setup properly.

## Ports

Each host can have multiple ports listening for traffic. Each port is TCP or UDP.

### TCP

TCP requires a connection to be established before data is sent. This is established
with the 'TCP handshake', a sequence of packets to setup a connection and to make sure
the two hosts are ready to send/recieve data. TCP ports are bidirectional so data
can be sent/recieved by both parties.

Ports up to 1024 are priviledged ports and they are already predefined for existing
services. Non-root users on a NIX machine are not allowed to bind to them to setup a
listening service.

Say Machine 2 connects to Machine 1:
```
[Machine 1] - Port 80/HTTP
               ^
               |
               |
               v
[Machine 2] - Randomly assigned local port - 5720
```
This connection between the two machines needs to be closed with another handshake. If
it isn't closed and a keepalive packet isn't recieved in a set time, it will time out
and the connection will be closed anyway.

While a connection is established, a packet sent across this connection is guaranteed
to be recieved, assuming the connection doesn't drop.

### UDP

UDP are connectionless packets which means they do not need to establish a connection.
The are one-directional. They are used for traffic which implement their own stability
algorithms. They are used where the overhead of TCP connection establishment is not
required or advantageous, for example, when the highest speed connection needs to be
made between two hosts.

There is no guarantee that a UDP packet will be recieved by the host, it is a 'fire and
forget' scenario.

### Using Nmap to show all the listening ports on a host

This runs a stealth SYN port scan without pinging the host first, which I generally find
to be the most tolerated port scan. You should not portscan hosts you don't own! It may be
interpreted as precursor to a hacking attempt.

`sudo apt install nmap`

```
david@W10-STUDIO-PC ~> sudo nmap -vvv -Pn -sS 192.168.1.50                                                             1
Starting Nmap 7.80 ( https://nmap.org ) at 2022-08-21 08:10 BST
Initiating Parallel DNS resolution of 1 host. at 08:10
Completed Parallel DNS resolution of 1 host. at 08:10, 0.00s elapsed
DNS resolution of 1 IPs took 0.00s. Mode: Async [#: 1, OK: 1, NX: 0, DR: 0, SF: 0, TR: 1, CN: 0]
Initiating SYN Stealth Scan at 08:10
Scanning Linksys05555 (192.168.1.50) [1000 ports]
Discovered open port 445/tcp on 192.168.1.50
Discovered open port 53/tcp on 192.168.1.50
Discovered open port 443/tcp on 192.168.1.50
Discovered open port 139/tcp on 192.168.1.50
Discovered open port 80/tcp on 192.168.1.50
Discovered open port 10000/tcp on 192.168.1.50
Discovered open port 49153/tcp on 192.168.1.50
Discovered open port 49152/tcp on 192.168.1.50
Completed SYN Stealth Scan at 08:10, 0.09s elapsed (1000 total ports)
Nmap scan report for Linksys05555 (192.168.1.50)
Host is up, received user-set (0.00071s latency).
Scanned at 2022-08-21 08:10:53 BST for 0s
Not shown: 992 closed ports
Reason: 992 resets
PORT      STATE SERVICE          REASON
53/tcp    open  domain           syn-ack ttl 63
80/tcp    open  http             syn-ack ttl 63
139/tcp   open  netbios-ssn      syn-ack ttl 63
443/tcp   open  https            syn-ack ttl 63
445/tcp   open  microsoft-ds     syn-ack ttl 63
10000/tcp open  snet-sensor-mgmt syn-ack ttl 63
49152/tcp open  unknown          syn-ack ttl 63
49153/tcp open  unknown          syn-ack ttl 63

Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds
           Raw packets sent: 1000 (44.000KB) | Rcvd: 1000 (40.032KB)
david@W10-STUDIO-PC ~>
```

So you can see the open ports listed, and the service they are normally associated with.

### Connecting to ports with Netcat

You can use the handy utility 'Netcat' `nc` to setup traffic to and from ports. Here I mimic
a very basic browser by connecting to port 80 (http) of www.google.com and issuing a 'GET /'
HTTP command, which means get the default index page.

`sudo apt install netcat`

```
david@W10-STUDIO-PC ~> nc google.com 80                                                                             130
GET /
```

Google.com replies first with a HTTP header, and then the HTML body, eg the web page source
in HTML (not shown because it's huge):

```
HTTP/1.0 200 OK
Date: Sun, 21 Aug 2022 07:17:41 GMT
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1
Server: gws
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
Set-Cookie: AEC=AakniGM3xC9t420FNYvPZPH5snTzCzBfDf60HD0oVpM3Rm8SUZEbk5VVAQ; expires=Fri, 17-Feb-2023 07:17:41 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
Accept-Ranges: none
Vary: Accept-Encoding
....
<HTML BODY follows>
....
```

It is interesting to observe that all TCP traffic can be encoded as text characters, so if you
knew the exact text characters to send via netcat, you could impersonate any type of network
connection by just typing it in! (assuming you don't get timed out). There is no backspace though :)

### Setup listening ports via Netcat

If you want to test a two-way connection via netcat, you can setup a listening netcat server
that binds to a port on the local machine, and then connect to it with the other machine.

This is a good way of diagnosing connection problems between two hosts.

On Machine 1 with an IP address of 192.168.51.1, to create a listening TCP connection
on port 4444:

`nc -l 4444`

On Machine 2 to connect to Machine 1:

`nc 192.168.51.1 4444`

If you are watching both machines, type something on each machine and you will see the text being
send between each machine (assuming the connection works). Terminate the connection from either side
with `Control-D`.


## Firewalls

Firewalls can be configured to restrict access of data traffic by port to a host. For
example with `ufw` on Ubuntu:
