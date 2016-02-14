#!/bin/bash

export RAILS_ENV=production; rails runner lib/report.rb > output.json
python lib/report_to_ss.py output.json

