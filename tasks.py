from invoke import task


@task
def test(c):
    c.run("zsh netscout.zsh")


@task
def install(c):
    # copy to ~/.config/systemd/user/
    c.run("cp -a ./netscout.service ./netscout.timer ~/.config/systemd/user/")
    c.run("systemctl --user reload-daemon")
    c.run("systemctl --user enable netscout.timer")


@task
def docker_build(c):
    docker = "podman"
    c.run(f"{docker} build . -t jrabbit/netscout:dev")


@task
def docker_run(c):
    docker = "podman"
    c.run(f"{docker} run -ti jrabbit/netscout:dev")
