#!/bin/bash
uvicorn vpn_api.main:app --host 0.0.0.0 --reload
