--------------------------------------------------------
--  DDL for Package PAC_IAX_PRESTAMOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "AXIS"."PAC_IAX_PRESTAMOS" AS
   /******************************************************************************
      NOMBRE:      PAC_IAX_PRESTAMOS
      PROPÃ“SITO:   Contiene las funciones de gestiÃ³n de los prestamos

      REVISIONES:
      Ver        Fecha        Autor             DescripciÃ³n
      ---------  ----------  ---------------  ------------------------------------
      1.0        30/11/2011   DRA               1. 0019238: LCOL_T001- PrÃ¨stecs de pÃ²lisses de vida
      2.0        19/09/2012   MDS               2. 0023749: LCOL_T001-Autoritzaci? de prestecs
      3.0        01/10/2012   MDS               3. 0023772: LCOL_T001-Reversi? de prestecs
      4.0        25/10/2012   MDS               4. 0024192: LCOL898-Modificacions Notificaci? recaudo CxC
      5.0        30/11/2012   AEG               5. 0024898: LCOL_T001-QT5354: Los prestamos que son cancelados o reversados no deben mostrarse en SIR para eventuales pagos de cuotas.
      6.0        30/11/2012   JRV              15. 0024448: LCOL_T001-LCOL - qtracker 5181 - Calcul venciments quadre amortitzaci?
   ******************************************************************************/
   vgobprestamos  ob_iax_prestamo;

   FUNCTION f_get_lstprestamos(
      psseguro IN NUMBER,
      pnriesgo IN NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_get_detprestamo(
      psseguro IN NUMBER,
      pnriesgo IN NUMBER,
      pctapres IN VARCHAR2,
      mensajes OUT t_iax_mensajes,
      pcuotadesc IN NUMBER DEFAULT 0,
      phastahoy IN NUMBER DEFAULT 0)
      RETURN ob_iax_prestamo;

   FUNCTION f_consulta_presta(
      pcramo IN NUMBER,
      psproduc IN NUMBER,
      pnpoliza IN NUMBER,
      pncertif IN NUMBER,
      pctapres IN VARCHAR2,
      pnnumide IN VARCHAR2,
      psnip IN VARCHAR2,
      pbuscar IN VARCHAR2,
      ptipoper IN NUMBER,
      pcactivi IN NUMBER,
      pfiltro IN NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_consulta_lstprst(
      psseguro IN NUMBER,
      pnriesgo IN NUMBER,
      pctapres IN VARCHAR2,
      mensajes OUT t_iax_mensajes)
      RETURN sys_refcursor;

   FUNCTION f_get_prestamo(mensajes OUT t_iax_mensajes)
      RETURN ob_iax_prestamo;

   FUNCTION f_get_prestamos(
      pctipdoc IN NUMBER,
      ptdoc IN VARCHAR2,
      pnpoliza IN NUMBER,
      pncertif IN NUMBER,
      pctapres IN VARCHAR2,
      mensajes OUT t_iax_mensajes,
      -- 2012/11/30 aeg BUG:0024898 se agrega el sig. parametro.
      pcestado IN NUMBER DEFAULT NULL,
      pcuotadesc IN NUMBER DEFAULT 0,
      phastahoy IN NUMBER DEFAULT 0)
      RETURN t_iax_prestamo;

   FUNCTION f_inicializa_prestamo(
      psseguro IN NUMBER,
      pnriesgo IN NUMBER,
      pctapres IN VARCHAR2,
      mensajes OUT t_iax_mensajes)
      RETURN ob_iax_prestamo;

   FUNCTION f_obtener_porcentaje(
      pfiniprest IN DATE,
      psproduc IN NUMBER,
      pinteres OUT NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_insertar_prestamo(
      psseguro IN NUMBER,
      pnriesgo IN NUMBER,
      pnmovimi IN NUMBER,
      pctapres IN VARCHAR2,
      pfiniprest IN DATE,
      pffinprest IN DATE,
      pffecpag IN DATE,
      picapital IN NUMBER,
      pcmoneda IN VARCHAR2,
      pporcen IN NUMBER,
      pctipo IN NUMBER,
      pctipban IN NUMBER,
      pcbancar IN VARCHAR2,
      pf1cuota IN DATE,
      cforpag IN NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

   FUNCTION f_anula_prestamo(pctapres IN VARCHAR2, mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

-- Bug 24448/135145 LCOL_T001-LCOL - qtracker 5181 - Calcul venciments quadre amortitzaci?
   FUNCTION f_calc_demora_cuota(
      pcmoneda IN NUMBER,
      picapital IN NUMBER,
      pfvencim IN DATE,
      psseguro IN NUMBER,
      psproduc IN NUMBER,
      pfecha IN DATE,
      pidemora OUT NUMBER,
      mensajes IN OUT t_iax_mensajes,
      pforigen IN DATE)
      RETURN NUMBER;

   /*************************************************************************
       f_mov_prestamocuota
       Funcion para insertar movimiento en las cuotas del prestamo
       param in pctapres      : Identificador del prÃ©stamo
       param in pfinicua     : VersiÃ³n del cuadro
       param in picappend    : capital pendiente
       param in pfvencim        : Fecha vencimiento de la cuota
       param in pidpago     : identificador del pago
       param in pnlinea      : identificador de la linea
       param out psmovcuo    : Secuencia movimiento cuota
       return              : 0 (todo Ok)
                             <> 0 (ha habido algun error)
    *************************************************************************/
   FUNCTION f_mov_prestamocuota(
      pctapres IN VARCHAR2,
      pfinicua IN DATE,
      picappend IN NUMBER,
      pfvencim IN DATE,
      pidpago IN NUMBER,
      pnlinea IN NUMBER,
      pfmovini IN DATE,
      pcestcuo IN NUMBER,
      psmovcuo OUT NUMBER,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   /*************************************************************************
       f_mov_prestamopago
       Funcion para insertar movimiento en el pago del prestamo
       param in pctapres      : Identificador del prÃ©stamo
       param in pnpago     : VersiÃ³n del cuadro
       param in pcestpag    : capital pendiente
       param in pcsubpag        : Fecha vencimiento de la cuota
       param in pfefecto     : identificador del pago
       param out pnmovpag    : NÃºmero de movimiento del pago
       return              : 0 (todo Ok)
                             <> 0 (ha habido algun error)
    *************************************************************************/
   FUNCTION f_mov_prestamopago(
      pctapres IN VARCHAR2,
      pnpago IN NUMBER,
      pcestpag IN NUMBER,
      pcsubpag IN NUMBER,
      pfefecto IN DATE,
      pnmovpag OUT NUMBER,
      mensajes IN OUT t_iax_mensajes)
      RETURN NUMBER;

   -- Ini Bug : 23749 - MDS - 19/09/2012
   /*************************************************************************
       f_mov_prestamos
       Funci�n para insertar un movimiento de pr�stamos
       param in  pctapres  : Identificador del pr�stamo
       param in  pfalta    : Fecha de alta del pr�stamo
       param in  pcestado  : Nuevo estado actual del pr�stamo
       param in  pfmovini  : Fecha inicio de vigencia del nuevo estado
       param out psmovpres : Secuencia del nuevo movimiento
       return              : 0 (todo OK)
                             <> 0 (ha habido algun error)
    *************************************************************************/
   FUNCTION f_mov_prestamos(
      pctapres IN VARCHAR2,
      pfalta IN DATE,
      pcestado IN NUMBER,
      pfmovini IN DATE,
      psmovpres OUT NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

   /*************************************************************************
       f_autorizar
       Funci�n para autorizar un pr�stamo
       param in  pctapres    : Identificador del pr�stamo
       param in  pfalta      : Fecha de alta del pr�stamo
       param in  pfautoriza  : Fecha de autorizaci�n del pr�stamo
       param in  pnmovimi    : N�mero de movimiento
       param in  pffecpag    : Fecha de efecto del pr�stamo
       param in  picapital   : Capital del pr�stamo
       return                : 0 (todo OK)
                               <> 0 (ha habido algun error)
    *************************************************************************/
   FUNCTION f_autorizar(
      pctapres IN VARCHAR2,
      pfalta IN DATE,
      pfautoriza IN DATE,
      pnmovimi IN NUMBER,
      pffecpag IN DATE,
      picapital IN NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

-- Fin Bug : 23749 - MDS - 19/09/2012

   -- Ini Bug 23772 - MDS - 01/10/2012

   /*************************************************************************
       f_reversar_prestamo
       Funci�n para reversar un pr�stamo
       param in  pctapres    : Identificador del pr�stamo
       param in  pfalta      : Fecha de alta del pr�stamo
       param in  pfrechaza   : Fecha de reversi�n del pr�stamo
       param in  pnmovimi    : N�mero de movimiento
       return                : 0 (todo OK)
                               <> 0 (ha habido algun error)
    *************************************************************************/
   FUNCTION f_reversar_prestamo(
      pctapres IN VARCHAR2,
      pfalta IN DATE,
      pfrechaza IN DATE,
      pnmovimi IN NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

-- Fin Bug 23772 - MDS - 01/10/2012
   FUNCTION f_permite_reversar(
      pctapres IN VARCHAR2,
      psepermite OUT NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

-- Ini Bug 24192 - MDS - 25/10/2012
   /*************************************************************************
        f_reversarpagar_prestamo
        Funci�n para reversar un pr�stamo
        param in pctapres       : Identificador del pr�stamo
        param in pfvalida       : Fecha de Reversi�n / Pago del pr�stamo
        param in ptipooperacion : Reversar / Pagar
        param out pnmovpag      : N�mero de movimiento del pago
        return : 0 (todo OK)
                                <> 0 (ha habido algun error)
     *************************************************************************/
   FUNCTION f_reversarpagar_prestamo(
      pctapres IN VARCHAR2,
      pfvalida IN DATE,
      ptipooperacion IN VARCHAR2,
      pnmovpag OUT NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;

-- Fin Bug 24192 - MDS - 25/10/2012

   -- BUG:2448 AMJ 22/02/2013  LCOL_T001-LCOL - qtracker 5181 - Calcul venciments quadre amortitzaci?  Ini
   FUNCTION f_calc_demora_cuota_prorr(
      pcmoneda IN NUMBER,
      picapital IN NUMBER,
      pforigen IN DATE,
      pfvencim IN DATE,
      psseguro IN NUMBER,
      psproduc IN NUMBER,
      pfecha IN DATE,
      pidemora OUT NUMBER,
      mensajes OUT t_iax_mensajes)
      RETURN NUMBER;
-- BUG: 24448  11/03/2013  AMJ   Se hace la nota 140238 Fin
END pac_iax_prestamos;

/

  GRANT EXECUTE ON "AXIS"."PAC_IAX_PRESTAMOS" TO "R_AXIS";
  GRANT EXECUTE ON "AXIS"."PAC_IAX_PRESTAMOS" TO "CONF_DWH";
  GRANT EXECUTE ON "AXIS"."PAC_IAX_PRESTAMOS" TO "PROGRAMADORESCSI";
