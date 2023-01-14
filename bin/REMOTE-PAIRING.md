#Remote Pairing Scripts

##Trainee:

    Run remote-pairing-1.sh on their Linux machine after connecting to the VPN.
    Follow the prompts and send the IP address reported via chat to the trainer.
    When prompted, run remote-pairing-2.sh and enter the username of the trainer.

##Trainer:

    ssh <trainer username>@<trainee IP address> after connecting to the VPN.
    screen -x <trainee username>/training_screen

That should allow both trainee and trainer to share the same terminal session.

Either party can terminate the shared screen by pressing Control-D at any time.
