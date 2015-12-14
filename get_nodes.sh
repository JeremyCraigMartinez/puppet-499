#!/bin/bash

JSON=$(puppet node find '*')
python check_with_nmap.py $JSON