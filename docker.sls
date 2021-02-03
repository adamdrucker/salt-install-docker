# -- Ubuntu --
{% if grains['os'] == 'Ubuntu' -%}

repo_packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg-agent
      - software-properties-common

docker_repository:
  pkgrepo.managed:
    - humanname: Docker
    - name: "deb https://download.docker.com/linux/ubuntu/ {{ grains['oscodename'] }} stable"
    - file: /etc/apt/sources.list
    - gpgcheck: 1
    - key_url: https://download.docker.com/linux/ubuntu/gpg

docker_install:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - require:
      - pkgrepo: docker_repository

# -- CentOS --
{% elif grains['os'] == 'CentOS' -%}

repo_packages:
  pkg.installed:
    - name: yum-utils

docker_repository:
  pkgrepo.managed:
    - pkgrepo.managed: docker-ce
    - baseurl: https://download.docker.com/linux/centos/$releasever/$basearch/stable
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://download.docker.com/linux/centos/gpg

docker_install:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - require:
      - pkgrepo: docker_repository

{%- endif %}
