#!/bin/bash

set -e
set -x

tod list view -f @"$1" | grep -v '#Important' | sed '/^$/d'



