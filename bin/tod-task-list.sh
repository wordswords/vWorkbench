#!/bin/bash

set -e
tod list view -f @"$1" | grep -v 'Important' | sed '/^$/d'



