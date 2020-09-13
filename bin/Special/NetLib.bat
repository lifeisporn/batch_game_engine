::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 - имя функции                                   ::
:: %~2 - переменная возврата                          ::
:: %3,%4,... - параметры функции                      ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ==================== Параметры =================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

SETLOCAL EnableExtensions EnableDelayedExpansion
SET "_RESULT="
GOTO %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ===================== Функции ==================== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: getUpdates()
:: getFixes()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: ============== function getUpdates() ============= ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getUpdates
SET _RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ================================================== ::
:: =============== function getFixes() ============== ::
:: ================================================== ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:getFixes
SET _RESULT=0
GOTO :return

::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:return
ENDLOCAL & SET %~2=%_RESULT%
GOTO :eof