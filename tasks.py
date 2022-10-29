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
    c.run("systemctl --user start netscout.timer")


@task
def docker_deps(c):
    docker = "podman"
    c.run(f"{docker} pull debian:bullseye")


@task
def docker_build(c):
    docker = "podman"
    c.run(f"{docker} build . -t jrabbit/netscout:dev")


@task
def docker_run(c):
    docker = "podman"
    c.run(f"{docker} run -v $PWD:/srv -ti jrabbit/netscout:dev")
