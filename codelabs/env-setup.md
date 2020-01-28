summary: Setup de l'environnement
id: env-setup
categories: Web
tags: medium
status: Published
authors: Simon

# Setup de l'environnement

<!-- ------------------------ -->

## Notes pour plus tard

Duration: 1

Attention: Toutes les étapes listées ici sont à réaliser sur votre machine. Et non pas
sur votre serveur SSH. Autrement vous ne serez pas en mesure de détecter votre
téléphone/tablette, une fois branché en USB.

Pour éviter tous problèmes potentiels, lancez ces requêtes depuis votre home

```bash
cd ~
```

<!-- ------------------------ -->

## Prérequis

Duration: 1

Assurez vous que vous avez un fichier `.bash_profile` ou `.bashrc` à la racine de votre home.

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

Vérifiez si vous avez node et npm d’installer. Vous devriez avoir la version 10 de node
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
C’est toujours la manière recommandé d’installer NodeJS.

Negative
: Pro tip: Si vous êtes obligé d’utiliser sudo avec npm, dites vous que votre installation est foiré.

### Installer NVM

Lancer la commande suivante

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
# Si vous n'avez pas curl essayez avec wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```

Ouvrez un nouveau terminal ou lancez

```bash
source ~/.bash_profile
# ou
source ~/.bashrc
```

Vous devriez pouvoir utiliser NVM

```bash
$ nvm --version
0.33.11
```

Si ce n’est pas le cas ajouter ceci à la fin de votre fichier .bash_profile ou .bashrc puis

réouvrez un nouveau terminal ou faites un `source`

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

Installez maintenant node et faites en votre version par defaut

```bash
nvm install --lts=Dubnium
nvm alias default lts/dubnium
$ nvm ls
-> v10.17.0
default -> lts/dubnium (-> v10.17.0)
```

<!-- ------------------------ -->

## Installer Java 8

Vérifiez d’abord votre installation de java: Ionic ne fonctionne pas avec les version plus récente de java. faites donc attention à ce que votre numéro de version corresponde à ceci (du moins pour le 1.8).

```bash
$ java -version
java version "1.8.0_192"
Java(TM) SE Runtime Environment (build 1.8.0_192-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.192-b12, mixed mode)
```

> Si la version affiché est 11 ou 13, vous êtes sur une version trop récente de java. Suivez [ces instructions](https://askubuntu.com/questions/1133216/downgrading-java-11-to-java-8) pour downgrade java.

Dans le cas ou java ne serait pas installé, exécuter les commandes suivantes

```bash
sudo apt-get update
sudo apt-get install default-jre
sudo apt-get install default-jdk
```

<!-- ------------------------ -->

## installer Gradle

Vérifiez d’abord votre installation

```bash
$ gradle -v
------------------------------------------------------------
Gradle 6.0.1
------------------------------------------------------------
Build time: 2019-11-18 20:25:01 UTC
Revision: fad121066a68c4701acd362daf4287a7c309a0f5
Kotlin: 1.3.50
Groovy: 2.5.8
Ant: Apache Ant(TM) version 1.10.7 compiled on September 1 2019
JVM: 1.8.0_192 (Oracle Corporation 25.192-b12)
OS: Mac OS X 10.15.1 x86_64
```

Pour installer gradle on utilisera sdkman. Avant de l’installer, vérifiez si vous l’avez déjà:

```bash
$ sdk version
sdkman 5.0.0+51
```

Si vous ne l’avez pas, exécutez la commande suivante

```bash
curl -s "https://get.sdkman.io" | bash
```

Ajoutez ensuite cette ligne à la fin de votre `.bash_profile` ou `.bashrc`

```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

Vous pouvez ensuite lancer un nouveau terminal ou lancer la commande

```bash
source ~/.bash_profile
# ou
source ~/.bashrc
```

Vous pouvez maintenant installer Gradle

```bash
sdk install gradle 6.1
```

## installer Android studio

Vous devrez installer Android Studio. Il ne sera pas utiliser pour coder mais nous fournira les outils nécessaire pour compiler, lancer notre app sur des devices ou créer des émulateurs.

[Android studio](https://developer.android.com/studio/)

Vous devez ensuite installer les SDK nécessaires pour nos futures compilations. Ouvrez le SDK Manager d’Android Studio. Si vous venez d’installer Android Studio il devrait s’afficher par défaut.

Choisissez la version 9 (Pie) d’Android (API 28) et installez la en prenant note de l’emplacement de sauvegarde du SDK. Prenez note de l’emplacement de sauvegarde des SDK et ajoutez ces lignes à votre `.bash_profile` ou `.bashrc` (Le chemin peut changer dépendant de votre OS).

```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
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

Vous devriez maintenant avoir accès à la commande “adb”. Tester la en listant les devices branché à votre ordinateur. Tant que vous n’avez pas un truc du genre “adb commande not found” vous êtes bon.

```bash
adb devices
```

<!-- ------------------------ -->

## Installation de Ionic

Pour installer ionic lancez simplement

```bash
npm i -g ionic cordova native-run cordova-res
```

pour vérifier que tout est bien installer:

```bash
$ npm ls -g --depth=0
/Users/simonbrigant/.nvm/versions/node/v10.17.0/lib
├── cordova@9.0.0
├── cordova-res@0.8.1
├── ionic@5.4.13
├── native-run@0.3.0
└── npm@6.11.3
```
