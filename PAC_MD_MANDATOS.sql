--------------------------------------------------------
--  DDL for Package PAC_MD_MANDATOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "AXIS"."PAC_MD_MANDATOS" IS
      /*******************************************************************************
    FUNCION f_consulta_mandatos
         -- Descripcion
   Par�metros:
    Entrada :


     Retorna un valor num�rico: 0 si ha grabado el mandato y 1 si se ha producido alg�n error.

   */
   FUNCTION f_consulta_mandatos(
      pnnumide IN VARCHAR2 DEFAULT NULL,
      pnombre IN VARCHAR2 DEFAULT NULL,
      pdeudormandante IN NUMBER DEFAULT NULL,
      pfvencimiento IN VARCHAR2 DEFAULT NULL,
      pformapago IN NUMBER DEFAULT NULL,
      pcbanco IN NUMBER DEFAULT NULL,
      pcbancar IN VARCHAR2 DEFAULT NULL,
      ptipotarjeta IN NUMBER DEFAULT NULL,
      pnumtarjeta IN VARCHAR2 DEFAULT NULL,
      pinstemisora IN NUMBER DEFAULT NULL,
      pmandato IN NUMBER DEFAULT NULL,
      paccion IN NUMBER DEFAULT NULL,
      psucursal IN VARCHAR2 DEFAULT NULL,
      pestado IN NUMBER DEFAULT NULL,
      pconsulta IN NUMBER DEFAULT NULL)
      RETURN sys_refcursor;

   FUNCTION f_consulta_mandatos_masiva(
      pestado IN NUMBER DEFAULT NULL,
      pnomina IN NUMBER DEFAULT NULL)
      RETURN sys_refcursor;

   FUNCTION f_set_mandatos_gestion(
      pnumfolio IN mandatos_gestion.numfolio%TYPE,
      paccion IN mandatos_gestion.accion%TYPE,
      pfproxaviso IN mandatos_gestion.fproxaviso%TYPE,
      pmotrechazo IN mandatos_gestion.motrechazo%TYPE DEFAULT NULL,
      pcomentario IN mandatos_gestion.comentario%TYPE DEFAULT NULL,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_get_lstacciones_mandato(
      pnumfolio IN mandatos_estados.numfolio%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_get_lstestados_mandmasiva(mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_get_acciones_mandmasiva(
      pestado IN mandatos.cestado%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_getestadosmandato(
      pnumfolio IN mandatos_estados.numfolio%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_getpolizasmandato(
      pnumfolio IN mandatos_seguros.numfolio%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_getgestionesmandato(
      pnumfolio IN mandatos_gestion.numfolio%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_get_folio(
      psperson_man IN mandatos.sperson%TYPE,
      psperson_ase IN tomadores.sseguro%TYPE,
      pcbancar IN mandatos.cbancar%TYPE,
      pnumfolio OUT mandatos_seguros.numfolio%TYPE,
      pfechamandato OUT mandatos_seguros.fechamandato%TYPE,
      psucursal OUT mandatos_seguros.sucursal%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_set_mandatos_gestion_masiva(
      pcadenanumfol IN VARCHAR2,
      paccion IN mandatos_masiva.accion%TYPE,
      pnomina OUT mandatos_masiva.nomina%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_imp_mandatos_gestion_masiva(
      paccion IN NUMBER,
      pnomina IN NUMBER,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   /* Gestion de mandatos, accion rechazo de mandato */
   FUNCTION f_imprime_rechazo(
      p_numfolio IN NUMBER,
      p_origen IN VARCHAR2,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   /* Gestion masiva, estado Envio a Matriz */
   FUNCTION f_imprime_enviomatriz(p_nomina IN NUMBER, mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   /* Gestion masiva, estado En Transito */
   FUNCTION f_imprime_entransito(p_nomina IN NUMBER, mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_consulta_documentos(
      pnomina IN mandatos_masiva.nomina%TYPE,
      mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_conscobradoresbanc(mensajes OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_set_mandatos_documentos(
      piddocgedox IN NUMBER,
      pnumfolio IN NUMBER,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_cons_doc_mandato(pnumfolio IN NUMBER, mensajes IN OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_usupermisogestion(
      pcmandato IN VARCHAR2,
      pnumfolio IN NUMBER,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;
END pac_md_mandatos;

/

  GRANT EXECUTE ON "AXIS"."PAC_MD_MANDATOS" TO "R_AXIS";
  GRANT EXECUTE ON "AXIS"."PAC_MD_MANDATOS" TO "CONF_DWH";
  GRANT EXECUTE ON "AXIS"."PAC_MD_MANDATOS" TO "PROGRAMADORESCSI";
