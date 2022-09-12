#!/usr/bin/env bash
for db in ~/initial_data/*.db; do echo $db; sqlite3 $db < add_rank_column.sql; done
