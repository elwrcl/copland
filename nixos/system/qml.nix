{ pkgs, ... }:
{
  environment.variables = {
    QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt6.qtbase}/lib/qt-6/plugins";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
  };

  environment.pathsToLink = [
    "/share/qt6"
  ];
}
