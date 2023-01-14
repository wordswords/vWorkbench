#!/bin/bash
set -e

echo "Enter the full username of the trainer: "
read -r trainer_username
screen_id=$(screen -ls | grep '[0-9]*\.training_screen' | sed -E 's/\s+([0-9]+)\..*/\1/')
echo "Screen ID: ${screen_id} Trainer username: ${trainer_username}"
screen -S "${screen_id}" -X multiuser on
screen -S "${screen_id}" -X acladd "${trainer_username}"
echo "Multiuser screen enabled."
