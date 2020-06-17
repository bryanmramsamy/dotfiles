# Prerequisites

## i3 and i3-gaps

### Dependencies

```bash
sudo apt install i3 libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake libxcb-shape0-dev
```

### Install and make i3-gaps

```bash
mkdir tmp
cd tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

cd ..

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
```

# SSH and GPG keys

# Generate and export a SSH key

- **Generating a new SSH key pair** by *GitLab* :
  - <https://gitlab.com/help/ssh/README#generating-a-new-ssh-key-pair>

# Generate and export a GPG key

- **Signing commits with GPG** vy *GitLab* :
  - <https://gitlab.com/help/user/project/repository/gpg_signed_commits/index.md>

# Sources

## i3 rice

- **i3wm** by *Code Cast* :

  - (YouTube) <https://www.youtube.com/watch?v=j1I63wGcvU4&list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf>

  - (GitHub) <https://github.com/alexbooker>

## Polybar

- **Tutoriel Unix/i3wm : Configuration d'i3wm** (French) by *Grafikart.fr* :

  - (YouTube) <https://www.youtube.com/watch?v=oHbJK6r2Xwo>

- **Let's Linux** by *budlabs* :

  - (YouTube) <https://www.youtube.com/watch?v=7RNgpvBMua0&list=PLt6-rPpOpkb3XKwdUoLtUhCqkMbyqomba>

  - (GitHub) <https://github.com/budlabs/youtube>
