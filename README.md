## MVMD: 
The MVMD is also availabel online at: [https://in.mathworks.com/matlabcentral/fileexchange/42141-empirical-wavelet-transforms](https://in.mathworks.com/matlabcentral/fileexchange/72814-multivariate-variational-mode-decomposition-mvmd)
Please cite as: Naveed ur Rehman (2026). Multivariate Variational Mode Decomposition (MVMD) (https://in.mathworks.com/matlabcentral/fileexchange/72814-multivariate-variational-mode-decomposition-mvmd), MATLAB Central File Exchange. Retrieved January 16, 2026.

The dataset used in this study is publicly available at: M. Cejnek, O. Vysata, M. Valis, et al., Novelty detection-based approach for Alzheimer’s disease and mild cognitive impairment diagnosis from EEG, Medical & Biological Engineering & Computing 59 (2021) 2287–2296. doi:10.1007/s11517-021-02427-6.

## Processing of the code:
Download all the files and save them in a specific folder on your computer.

Locate the main script/file (e.g., Main_AMTFSN_Code.m).

Open the main file and update the required details:

    1. Path to the data folder

    2. Sampling rate

    3. Any other dataset-specific parameters and deep neural network-based hyperparameters

Save the changes.

Execute the code step by step, running each command or section in sequence to ensure everything works as expected.


## AMTFSNPrediction Executable (for standalone MATLAB application)

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

Files to Package for Standalone MATLAB Application 
================================
-AMTFSNPrediction.exe
-MCRInstaller.exe 
    Note: if end users are unable to download the MATLAB Runtime using the
    instructions in the previous section, include it when building your 
    component by clicking the "Runtime included in package" link in the
    Deployment Tool.
-This readme file 

3. Definitions
   For information on deployment terminology, go to https://www.mathworks.com/help and select MATLAB Compiler > Getting Started > About Application Deployment > Deployment Product Terms in the MathWorks Documentation center.

4. Once installed, open the application.

5. Enter the "sampling frequency" of the mEEG signal (e.g., 128 Hz).

6. "Load" the EEG file in CSV (.csv) format from the specified "file path".

7. Click on the "PredictButton" to begin the analysis.

8. The predicted results will be displayed in the "Result" sections.

Deployment Product Terms in the MathWorks Documentation
Center.
