enum PAGES {
  loading,
  welcome,
  login,
  register,
  registerData,
  registerBeneficiario,
  registerTerms,
  registerConfirm,
  home,
  menu,
  perfil,
  beneficios,
  reservas,
  beneficiarios,
  noticias,
  contacto,
  calendario,
  colegio,
}

extension AppPageExtension on PAGES {
  String get pagePath {
    switch (this) {
      case PAGES.loading:
        return "/";
      case PAGES.login:
        return "/login";
      case PAGES.welcome:
        return "/welcome";
      case PAGES.register:
        return "/register";
      case PAGES.registerData:
        return "/registerData";
      case PAGES.registerBeneficiario:
        return "/registerBeneficiario";
      case PAGES.registerTerms:
        return "/registerTerms";
      case PAGES.registerConfirm:
        return "/registerConfirm";
      case PAGES.home:
        return "/home";
      case PAGES.menu:
        return "/menu";
      case PAGES.perfil:
        return "/perfil";
      case PAGES.beneficios:
        return "/beneficios";
      case PAGES.reservas:
        return "/reservas";
      case PAGES.beneficiarios:
        return "/beneficiarios";
      case PAGES.noticias:
        return "/noticias";
      case PAGES.contacto:
        return "/contacto";
      case PAGES.calendario:
        return "/calendario";
      case PAGES.colegio:
        return "/colegio";

      default:
        return "/";
    }
  }

  String get pageName {
    switch (this) {
      case PAGES.loading:
        return "loading";
      case PAGES.welcome:
        return "welcome";
      case PAGES.login:
        return "login";
      case PAGES.register:
        return "register";
      case PAGES.registerData:
        return "registerData";
      case PAGES.registerBeneficiario:
        return "registerBeneficiario";
      case PAGES.registerTerms:
        return "registerTerms";
      case PAGES.registerConfirm:
        return "registerConfirm";
      case PAGES.home:
        return "home";
      case PAGES.menu:
        return "menu";
      case PAGES.perfil:
        return "perfil";
      case PAGES.beneficios:
        return "beneficios";
      case PAGES.reservas:
        return "reservas";
      case PAGES.beneficiarios:
        return "beneficiarios";
      case PAGES.noticias:
        return "noticias";
      case PAGES.contacto:
        return "contacto";
      case PAGES.calendario:
        return "calendario";
      case PAGES.colegio:
        return "colegio";

      default:
        return 'loading';
    }
  }
}
