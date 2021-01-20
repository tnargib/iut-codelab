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
npm i -g @ionic/cli native-run cordova-res
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

<!-- ------------------------ -->

## Installation Windows avec WSL

Negative
: Bien que cette solution semble intéressante, elle apporte tout de même sont lot de complication (A commencé par l'installation). Aussi je vous conseille vivement dans la mesure du possible d'installer Node directement sur votre Windows. Si votre installation de Node est bancale, désinstallez - réinstallé le. NodeJS est un logiciel comme un autre, des package NPM ça se réinstalle en un tour de bras !

Si vous préférez, il vous est possible d'effectuer les étapes listées ci dessus depuis une vrai distribution Linux grâce à la fonction de sous système Linux pour Windows.

Pour ce faire installez WSL sur votre ordianteur en suivant les instructions listées ici : <https://docs.microsoft.com/fr-fr/windows/wsl/install-win10> puis installez votre distribution Linux. (On conseillera généralement Ubuntu pour rester sur un système standard et largement documenté)

Vous avez ensuite quelques manipulations à faire pour rendre certain de vos outils windows disponible sous Linux.

### Dans votre Windows

Vous allez devoir créer 2 variables d'environnements pour les passer ensuite à votre environnement WSL.

- ANDROID_SDK_ROOT: La localisation de vos outils de dévelopement Android. (Le chemin qui vous est indiqué dans Android Studio). `Ex: C:\Users\simon\AppData\Local\Android\Sdk`.
<!-- - ANDROID_STUDIO_ROOT: Le chemin vers le dossier d'installation de Android Studio. `Ex: C:\Program Files\Android\Android Studio\bin`. -->
- WSL_SHARED: Le chemin vers un dossier que vous allez partager entre vos deux distributions (Vous devriez de préférence créer un nouveau dossier spécifique pour ça plutôt que d'en réutiliser un existant, pour éviter les conneries). `Dans mon cas: D:\sharedwsl`.

Vous allez maintenant devoir créer une dernière variable d'environnement qui va permettre de partager ces dernières avec votre distribution Linux.

`WSLENV: WSL_SHARED/p:ANDROID_SDK_ROOT/p`

Positive
: le `/p` ici est important. Il va indiquer à Windows qu'il faut "traduire" ces variables pour Linux. Pas de `\` en linux par exemple.

### Dans votre ditribution Linux

Créez ensuite à la racine de votre home un dossier `SharedWSL` qui sera un raccourci vers le dossier que vous avez créer sur votre windows.

```bash
ln -s $WSL_SHARED SharedWSL
```

Vosu pouvez maintenant cd dans ce dossier, et vous vérez que si vous créez des fichier dedans depuis votre Linux, il apparaitront dedans sous Windows également.

Vous pouvez maintenant, dans votre Linux, installer Node + Ionic et lancer votre ionic start dans le dossier SharedWSL.

Negative
: Le Live Reload ne marchera sur un environnement comme celui la. Par conséquent vous ne pouvez pas utiliser les commandes `ionic capacitor run ...` et `ionic capacitor open ...`. Par conséquent, à chaque fois que vous voudrez voir les changement que vous avez fait à votre app vous devrez lancer un `ionic capacitor copy android` voir un `ionic capacitor sync android`.
