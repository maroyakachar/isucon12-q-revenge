#!/usr/bin/env bash
for db in ~/initial_data/*.db; do echo $db; sqlite3 $db < delete_older_score.sql; done
