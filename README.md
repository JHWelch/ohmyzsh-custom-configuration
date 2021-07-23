# ohmyzsh Custom Configuration
Template for a repo containing your Zsh custom configuration that can be easily deployed to the ohmyzsh `custom` folder.  

## Requirements
* On Mac requires GNU Coreutils package. Can be installed with `brew install coreutils`

## Usage
### Folder Stucture
* All .zsh files in the root folder will be symlinked directly in the Oh-My-Zsh custom folder
* All .zsh-theme files in [the themes folder](./themes/) will be symlinked in the Oh-My-Zsh custom/themes folder
* The [repo](./plugins/repos) file will clone all repos listed into the Oh-My-Zsh custom/plugins folder 

### Deployment
The configuration should not be manually copied into Oh My Zsh, it can be deployed using Symbolic links.

#### Steps
1. run `sh deploy-zsh-config.sh`
