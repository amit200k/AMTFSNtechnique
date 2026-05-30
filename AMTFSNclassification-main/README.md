## MVMD: 
The MVMD is also availabel online at: [https://in.mathworks.com/matlabcentral/fileexchange/42141-empirical-wavelet-transforms](https://in.mathworks.com/matlabcentral/fileexchange/72814-multivariate-variational-mode-decomposition-mvmd)
Please cite as: Naveed ur Rehman (2026). Multivariate Variational Mode Decomposition (MVMD) (https://in.mathworks.com/matlabcentral/fileexchange/72814-multivariate-variational-mode-decomposition-mvmd), MATLAB Central File Exchange. Retrieved January 16, 2026.

## Processing of the code:
Download all the files and save them in a specific folder on your computer.

Locate the main script/file (e.g., Main_AMTFSN_Code.m).

Open the main file and update the required details:

    1. Path to the data folder

    2. Sampling rate

    3. Any other dataset-specific parameters and deep neural network-based hyperparameters

Save the changes.

Execute the code step by step, running each command or section in sequence to ensure everything works as expected.












## AMTFSNPrediction Executable %%%% FOR APPLICATION

1. Prerequisites for Deployment 

Verify that MATLAB Runtime(R2024b) is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter
  
    >>mcrinstaller
      
at the MATLAB prompt.
NOTE: You will need administrator rights to run the MATLAB Runtime installer. 

Alternatively, download and install the Windows version of the MATLAB Runtime for R2024b 
from the following link on the MathWorks website:

    https://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler documentation  
in the MathWorks Documentation Center.

2. Files to Deploy and Package

Files to Package for Standalone 
================================
-AMTFSNPrediction.exe
-MCRInstaller.exe 
    Note: if end users are unable to download the MATLAB Runtime using the
    instructions in the previous section, include it when building your 
    component by clicking the "Runtime included in package" link in the
    Deployment Tool.
-This readme file 



3. Definitions

For information on deployment terminology, go to
https://www.mathworks.com/help and select MATLAB Compiler >
Getting Started > About Application Deployment >
Deployment Product Terms in the MathWorks Documentation
Center.
