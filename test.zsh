#!/usr/bin/env zsh

curl -k --form "token=abc" https://localhost:8001/register
curl -k --form "token=abc" --form "system=ios" https://localhost:8001/activate
