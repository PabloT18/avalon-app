enum PAGES {
  loading,

  login,
  register,

  home,
  perfil,
  editPerfil,
  editPerfilDatPer,
  editPerfilDir,
  preferencias,

  citas,
  detalleCita,
  crearCita,
  emergencia,
  emergenciaDetalle,
  crearEmergencia,
  reclamacionDetalle,
  crearReclamacion,
  casos,
  crearCaso,
  detaleCaso,
  reclamaciones,
  seguros,
  familiares,
  addFamiliar,
  membresias,

  noticias,
  preguntas,
  formasPago,
  medicos,
  centrosMedicos,
  aboutus,
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
      case PAGES.perfil:
        return "/perfil";
      case PAGES.editPerfil:
        return "/editPerfil";
      case PAGES.editPerfilDatPer:
        return "/editPerfilDatPer";
      case PAGES.editPerfilDir:
        return "/editPerfilDir";

      case PAGES.preferencias:
        return "/preferencias";
      case PAGES.citas:
        return "/citas";
      case PAGES.detalleCita:
        return "/detalleCita";
      case PAGES.crearCita:
        return "/crearCita";
      case PAGES.emergencia:
        return "/emergencia";
      case PAGES.emergenciaDetalle:
        return "/emergenciaDetalle";
      case PAGES.crearEmergencia:
        return "/crearEmergencia";
      case PAGES.reclamacionDetalle:
        return "/reclamacionDetalle";
      case PAGES.crearReclamacion:
        return "/crearReclamacion";

      case PAGES.casos:
        return "/casos";
      case PAGES.crearCaso:
        return "/crearCaso";
      case PAGES.detaleCaso:
        return "/detaleCaso";

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

      case PAGES.noticias:
        return "/noticias";

      case PAGES.preguntas:
        return "/preguntas";
      case PAGES.formasPago:
        return "/formasPago";
      case PAGES.medicos:
        return "/medicos";
      case PAGES.centrosMedicos:
        return "/centrosMedicos";
      case PAGES.aboutus:
        return "/aboutus";
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

      case PAGES.perfil:
        return "perfil";
      case PAGES.editPerfil:
        return "editPerfil";
      case PAGES.editPerfilDatPer:
        return "editPerfilDatPer";
      case PAGES.editPerfilDir:
        return "editPerfilDir";

      case PAGES.preferencias:
        return "preferencias";
      case PAGES.citas:
        return "citas";
      case PAGES.detalleCita:
        return "detalleCita";
      case PAGES.crearCita:
        return "crearCita";
      case PAGES.emergencia:
        return "emergencia";
      case PAGES.emergenciaDetalle:
        return "emergenciaDetalle";
      case PAGES.crearEmergencia:
        return "crearEmergencia";
      case PAGES.reclamacionDetalle:
        return "reclamacionDetalle";
      case PAGES.crearReclamacion:
        return "crearReclamacion";
      case PAGES.casos:
        return "casos";
      case PAGES.crearCaso:
        return "crearCaso";
      case PAGES.detaleCaso:
        return "detaleCaso";
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
      case PAGES.noticias:
        return "noticias";

      case PAGES.preguntas:
        return "preguntas";
      case PAGES.formasPago:
        return "formasPago";
      case PAGES.medicos:
        return "medicos";
      case PAGES.centrosMedicos:
        return "centrosMedicos";
      case PAGES.aboutus:
        return "aboutus";
      default:
        return 'loading';
    }
  }
}
