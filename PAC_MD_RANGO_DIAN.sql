CREATE OR REPLACE PACKAGE pac_md_rango_dian IS

    /******************************************************************************
      NOMBRE:     pac_md_rango_dian
      PROPÓSITO:  Funciones rango dian

      REVISIONES:
      Ver        Fecha        Autor             Descripción
      ---------  ----------  ---------------  ------------------------------------
      1.0        26/08/2016   FOR               1. Creación del package.
      2.0        19/06/2019   JLTS              2. Se incluye esta columna SPRODUC en f_set_versionesdian
   ******************************************************************************/

	/*************************************************************************
	Recupera Versiones Dian

	*************************************************************************/
	FUNCTION f_get_versionesdian(
		psrdian IN NUMBER,
			 presolucion	IN	NUMBER,
			 psucursal	  IN	NUMBER,
			 pcgrupo	    IN	VARCHAR2,
       pdescrip	    IN	VARCHAR2,
       pusuario	    IN	VARCHAR2,
       PMAIL  	    in	number,
       PCACTIVI IN NUMBER,
       pcramo   IN NUMBER,
       PTESTADO  	    in	number,
			 mensajes	OUT	T_IAX_MENSAJES
	)   RETURN SYS_REFCURSOR;

  FUNCTION f_set_versionesdian(
		psrdian  IN NUMBER,
			  pnresol    IN NUMBER,
        pcagente   IN NUMBER,
        pcgrupo   IN VARCHAR2,
        pfresol    IN DATE,
        pfinivig   IN DATE,
        pffinvig   IN DATE,
        ptdescrip  IN VARCHAR2,
        pninicial  IN NUMBER,
        pnfinal    IN NUMBER,
        pcusu      IN VARCHAR2,
        ptestado   IN VARCHAR2,
        pcenvcorr  IN VARCHAR2,
        pnaviso    IN NUMBER,
        pncertavi  IN NUMBER,
        pncontador IN NUMBER,
        PMODO      in varchar2,
        PCACTIVI IN NUMBER,
        pcramo IN    NUMBER,
        psproduc   IN NUMBER, --IAXIS-3288 -JLTS -19/06/2019. Se incluye esta columna
			  mensajes	 OUT	T_IAX_MENSAJES
	)   RETURN NUMBER;
	FUNCTION f_get_gruposdian(
			 mensajes	IN OUT	T_IAX_MENSAJES
	)   RETURN SYS_REFCURSOR;
END pac_md_rango_dian;
/
