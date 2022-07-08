{ pkgs, ... }:

let
  wiki = {
    name = "Crystal Linux Wiki";
    domain = "wiki.getcryst.al";
    admin = "michal@tar.black";
    passwdPath = "/secret";
    useSsl = false;
    listenAddress = "*";
    port = 80;
    color = "#a900ff";
    logoPath = ./logo.png;
  };
in
{
  services.mediawiki = {
    enable = true;
    name = wiki.name;
    virtualHost = {
      hostName = wiki.domain;
      adminAddr = wiki.admin;
      listen = [
        {
          ip = wiki.listenAddress;
          port = wiki.port;
          ssl = wiki.useSsl;
        }
      ];
      locations = {
        "/logo.png" = {
          alias = wiki.logoPath;
        };
        "/favicon.ico" = {
          alias = wiki.logoPath;
        };
      };
    };
    passwordFile = wiki.passwdPath;
    extraConfig = ''
      # Disable anonymous editing
      $wgGroupPermissions['*']['edit'] = false;
        
      # Set theme
      wfLoadSkin( 'citizen' );
      $wgDefaultSkin = 'citizen';
      $wgLogo = 'logo.png';
      
      # Theme customisation
      $wgCitizenThemeColor = '${wiki.color}';
      $wgCitizenManifestThemeColor = '${wiki.color}';
      $wgCitizenManifestBackgroundColor = '${wiki.color}';
    '';
    extensions = {
      visualEditor = pkgs.fetchzip {
        url = "https://extdist.wmflabs.org/dist/extensions/VisualEditor-REL1_38-942e773.tar.gz";
        sha256 = "JgCu6tv7sk0LFrb3UMNS+56EuIjd1/mmvngNAzOvGA8=";
      };
    };
    skins = {
      citizen = pkgs.fetchzip {
        url = "https://github.com/StarCitizenTools/mediawiki-skins-Citizen/archive/refs/tags/v1.17.7.zip";
        sha256 = "RNPWCJ8UtmNjch6moBLAPQyRRZHZ3q1W4DosavcyRK4=";
      };
    };
  };
  
  services.automysqlbackup = {
    enable = true;
    config = {
      db_names = [ "mediawiki" ];
      mailcontent = "log";
      mail_address = "null@tar.black";
    };    
  };
  
  networking.firewall = {
    allowedTCPPorts = [ wiki.port ];
  };
  
  environment.systemPackages = with pkgs; [
    imagemagickBig  
  ];
}
