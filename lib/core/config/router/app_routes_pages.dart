enum PAGES {
  loading,

  login,
  register,

  home,
  editPerfil,
  preferencias,
  reclamaciones,
  seguros,
  familiares,
  addFamiliar,
  membresias,
}

extension AppPageExtension on PAGES {
  String get pagePath {
    switch (this) {
      case PAGES.loading:
        return "/";
      case PAGES.login:
        return "/login";

      case PAGES.register:
        return "/register";
      case PAGES.home:
        return "/home";
      case PAGES.editPerfil:
        return "/editPerfil";
      case PAGES.preferencias:
        return "/preferencias";
      case PAGES.reclamaciones:
        return "/reclamaciones";
      case PAGES.seguros:
        return "/seguros";
      case PAGES.familiares:
        return "/familiares";
      case PAGES.addFamiliar:
        return "/addFamiliar";
      case PAGES.membresias:
        return "/membresias";

      default:
        return "/";
    }
  }

  String get pageName {
    switch (this) {
      case PAGES.loading:
        return "loading";

      case PAGES.login:
        return "login";
      case PAGES.register:
        return "register";

      case PAGES.home:
        return "home";
      case PAGES.editPerfil:
        return "editPerfil";
      case PAGES.preferencias:
        return "preferencias";
      case PAGES.reclamaciones:
        return "reclamaciones";
      case PAGES.seguros:
        return "seguros";
      case PAGES.familiares:
        return "familiares";
      case PAGES.addFamiliar:
        return "addFamiliar";

      case PAGES.membresias:
        return "membresias";

      default:
        return 'loading';
    }
  }
}
