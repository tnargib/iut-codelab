summary: Préparation de l'environnement
id: env-setup
categories: Web
tags: ionic
status: Published
authors: Simon

# Setup de l'environnement

<!-- ------------------------ -->

## Notes pour plus tard

Duration: 1

Negative
: **Attention:** Toutes les étapes listées ici sont à réaliser **sur votre machine**. Et non pas sur votre serveur SSH. Autrement vous ne serez pas en mesure de détecter votre téléphone/tablette, une fois branché en USB.

<!-- ------------------------ -->

## Prérequis

Duration: 1

Assurez vous que vous avez un fichier de configuration de shell `~/.bash_profile`, `~/.zshrc`, `~/.profile`, ou `~/.bashrc` à la racine de votre home.

```bash
$ ls -la ~
-rw-r--r-- 1 simonbrigant staff 3761 26 déc 11:58 .bash_profile
```

Si vous n’avez aucun de ces deux fichiers. Lancez la commande suivante

```bash
touch ~/.bash_profile
```

<!-- ------------------------ -->

## Installation de NodeJS et NPM

Vérifiez si vous avez node et npm d’installer. Vous devriez avoir au moins la version 10 de node
(lts/dubnium)

```bash
$ node -v
v10.17.0
$ npm -v
6.11.3
```

Si ce n’est pas le cas, vous allez installer node avec `NVM` (Node Version Manager). Ce
logiciel vous permet de gérer plusieurs version de node en même temps et vous assure que
votre installation sera propre et sans problème de permission par exemple.

> C’est toujours la manière recommandé d’installer NodeJS !

Negative
: Pro tip: Si vous êtes obligé d’utiliser sudo avec npm, dites vous que votre installation est foiré.

### Installer NVM

Lancer la commande suivante

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
# Si vous n'avez pas curl essayez avec wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```

Ouvrez un nouveau terminal ou recharger la configuration de votre shell

```bash
source ~/.bash_profile
# ou selon votre shell: .bash_profile, .zshrc etc
```

Vous devriez pouvoir utiliser NVM

```bash
$ nvm --version
0.33.11
```

Si ce n’est pas le cas ajouter ceci à la fin de votre fichier .bash_profile ou .bashrc puis réouvrez un nouveau terminal ou faites un `source`

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

Installez maintenant node et faites en votre version par defaut

```bash
nvm install --lts
$ nvm ls
-> v10.17.0
default -> lts/* (-> v10.17.0)
```

<!-- ------------------------ -->

## Installer Java 8

Negative
: C'est une parti un peu tricky car Java 8 a été déprécié (Bien sur, personne ne demandera pourquoi diable travail t'on encore avec alors) Si vous avez des soucis n'hésitez surtout pas à me demander et surtout sur cette partie.

Vérifiez d’abord votre installation de java: Malheureusement pour nous, Ionic ne fonctionne pas avec les version plus récente de java. faites donc attention à ce que vous aillez le **JDK8 (numéro de version 1.8).**

```bash
$ java -version
java version "1.8.0_192"
Java(TM) SE Runtime Environment (build 1.8.0_192-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.192-b12, mixed mode)
```

> Si la version affiché est 11 ou 13, vous êtes sur une version trop récente de java, souvent installé par défaut. Suivez [ces instructions](https://askubuntu.com/questions/1133216/downgrading-java-11-to-java-8) pour downgrade java.

Dans le cas ou java ne serait pas installé, exécuter les commandes suivantes

```bash
sudo apt-get update
sudo apt install openjdk-8-jdk
```

Si cette methode ne marche pas vous pouvez tenter celle la, surtout si vous êtes sur Debian 10 qui n'embarque plus certain repos.

```bash
apt-get update
apt-get install software-properties-common
apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
apt-get update
apt-get install openjdk-8-jdk
```

## installer Android studio

Vous devrez installer Android Studio. Il ne sera pas utilisé pour coder mais nous fournira les outils nécessaire pour compiler, lancer notre app sur des devices ou créer des émulateurs.

[Android studio](https://developer.android.com/studio/)

Quand vous lancerez Android Studio, dites lui de garder la config de base qui sera suffisante pour nous. Ca téléchargera les sdks de base et un simulateur.

Pour que les outils d'Android soit utilisable par le shell (et donc par capacitor) vous devez renseigner leurs emplacements dans la configuration de votre shell. **Ouvrez votre fichier .bash_profile ou autre** avec nano ou ce que vous voulez.

Positive
: Pour connaitre l'emplacement des outils de dev d'Android, ouvrez Android Studio et allez dans `Tools -> SDK Manager`. Puis copiez le chemin dans `Android SDK Location`.

Prenez note de l’emplacement de sauvegarde des SDK et ajoutez ces lignes à votre `.bash_profile` ou `.bashrc` (Le chemin peut changer dépendant de votre OS).

```bash
export ANDROID_SDK_ROOT=/Users/simonbrigant/Library/Android/sdk
# avdmanager, sdkmanager
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
# adb, logcat
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# emulator
```

Ouvrez un nouveau terminal ou exécuter la commande

```bash
source ~/.bash_profile
```

Vous devriez maintenant avoir accès à la commande “adb”. Tester la en listant les devices branché à votre ordinateur. Tant que vous n’avez pas un truc du genre `adb commande not found` vous êtes bon.

```bash
adb devices
```

<!-- ------------------------ -->

## Installation de Ionic

Pour installer ionic lancez simplement

```bash
npm i -g ionic native-run cordova-res
```

pour vérifier que tout est bien installer:

```bash
$ npm ls -g --depth=0
/Users/simonbrigant/.nvm/versions/node/v10.17.0/lib
├── ionic@5.4.13
├── native-run@0.3.0
└── npm@6.11.3
```

Positive
: Ne faites pas attention à native-run et cordova-res. Il nous serviront plus tard.
