@echo off
REM ============================================================================
REM ANSYS MECHANICAL APDL BATCH EXECUTION SCRIPT
REM Project: Mechanical Vibration Analysis Using MATLAB & ANSYS (NIT Hamirpur)
REM ============================================================================
REM Requirements: ANSYS Mechanical APDL (v19.0 to 2024R2 or later)
REM Usage: Run this batch script in Windows Command Prompt with ANSYS in PATH.
REM ============================================================================

echo ========================================================
echo    NIT HAMIRPUR - 2-DOF VIBRATION APDL SOLVER BATCH     
echo ========================================================

where ansys242.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set ANSYS_CMD=ansys242.exe
) else (
    set ANSYS_CMD=ansys.exe
)

echo [1/2] Running Modal Analysis (modal_analysis.inp)...
%ANSYS_CMD% -b -i modal_analysis.inp -o modal_run.out
echo Modal Analysis Complete. Output saved to modal_run.out and ansys_modal_results.txt.

echo [2/2] Running Harmonic Response Analysis (harmonic_analysis.inp)...
%ANSYS_CMD% -b -i harmonic_analysis.inp -o harmonic_run.out
echo Harmonic Analysis Complete. Output saved to harmonic_run.out and ansys_harmonic_frf_data.txt.

echo ========================================================
echo    ALL ANSYS APDL SIMULATIONS FINISHED SUCCESSFULLY     
echo ========================================================
pause
