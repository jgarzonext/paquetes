--------------------------------------------------------
--  DDL for Package PAC_AGE_SINIESTROS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "AXIS"."PAC_AGE_SINIESTROS" AS
/******************************************************************************
    NOMBRE:       PAC_AGE_SINIESTROS
    PROP?SITO:
                Tratamiento de los actores de siniestros

    REVISIONES:
    Ver        Fecha        Autor             Descripci??n
    ---------  ----------  ---------------  ------------------------------------
    1.0        14/03/2012   BFP                1. 0021524: MDP - COM - AGENTES Secci?n siniestros
******************************************************************************/

   /*************************************************************************
       Prop?sito:
                    inserir un registre a la taula sin_agentes
       param in psclave     : clave unica
       param in pcagente    : Codigo de agente
       param in pctramte    : Tipo de tramite
       param in pcramo      : c?digo ramo
       param in pctipcod    : Indica si es agente o profesional (VF 740)
       param in pctramitad  : Codigo de tramitador
       param in psprofes    : Codigo de profesional
       param in pcvalora    : Preferido/Excluido (VF 741)
       param in pfinicio    : Fecha desde
       param in pffin       : Fecha hasta
       param in pcusuari    : Usuario creador
       param in pfalta      : Fecha de alta
            return             : 0 inserci? correcta
                              <> 0 inserci? incorrecta
   *************************************************************************/
   FUNCTION f_set_actor(
      psclave IN NUMBER,
      pcagente IN NUMBER,
      pctramte IN NUMBER,
      pcramo IN NUMBER,
      pctipcod IN NUMBER,
      pctramitad IN VARCHAR2,
      psprofes IN NUMBER,
      pcvalora IN NUMBER,
      pfinicio IN DATE,
      pffin IN DATE,
      pcusuari IN VARCHAR2,
      pfalta IN DATE)
      RETURN NUMBER;

/*************************************************************************
       Prop?sito:
                    donar de baixa l'actor
       param in psclave     : clave ?nica
       param in pffin    : fecha hasta
            return             : 0 actualitzaci? correcta
                              <> 0 actualitzaci? incorrecta
   *************************************************************************/
   FUNCTION f_remove_actor(psclave IN NUMBER)
      RETURN NUMBER;
END pac_age_siniestros;

/

  GRANT EXECUTE ON "AXIS"."PAC_AGE_SINIESTROS" TO "R_AXIS";
  GRANT EXECUTE ON "AXIS"."PAC_AGE_SINIESTROS" TO "CONF_DWH";
  GRANT EXECUTE ON "AXIS"."PAC_AGE_SINIESTROS" TO "PROGRAMADORESCSI";
