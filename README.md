# Fuzzy Delphi Module for Jamovi
## Background
The fuzzy Delphi method (FDM) is a modified version of the classical Delphi technique that applies fuzzy set theory to handle the ambiguity and vagueness in expert opinions. Jamovi is an open source statistical software that is user-friendly and based on R programming language. The project investigates the evolution of a FDM module that has been incorporated into Jamovi and explores its potential uses and benefits.
Currently, only work with Jamovi 2.3.28 version. The researchers will update soon. 

Paper link: Chan , L.-K., Tan , S. K., & Noor Fatihah, B. M. (2025). FuzzyDelphiJmv: Jamovi Module for Fuzzy Delphi Module. Foundations and Trends ® in Information Systems, 11(1), 24–30, doi: [https://doi.org/10.5281/zenodo.15662068]. [https://fntis-journal.org/wp-content/uploads/FnTIS-2025-01-02.pdf](https://fntis-journal.org/wp-content/uploads/FnTIS-2025-01-02.pdf)


### References
Please cite the following:

[1] Chan , L.K., Tan , S. K., & Noor Fatihah, B. M. (2025). FuzzyDelphiJmv: Jamovi Module for Fuzzy Delphi Module. Foundations and Trends ® in Information Systems, 11(1), 24–30, doi: https://doi.org/10.5281/zenodo.15662068. [https://fntis-journal.org/wp-content/uploads/FnTIS-2025-01-02.pdf](https://fntis-journal.org/wp-content/uploads/FnTIS-2025-01-02.pdf)

[2] Chan, LK (2024) FuzzyDelphiJmv (Version 1.0) [Computer software]. Retrieved from
https://lerlerchan.github.io/FuzzyDelphiJmv/

[3] The jamovi project (2022). jamovi. (Version 2.3) [Computer Software]. Retrieved from https://www.jamovi.org.

#### Our module references the work of
Md Jani, Noraniza & Zakaria, Mohd & Maksom, Zulisman & Shariff, Md & Mustapha, Ramlan. (2018). Consequences of Customer Engagement in Social Networking Sites : Employing Fuzzy Delphi Technique for Validation. International Journal of Advanced Computer Science and Applications. 9. [10.14569/IJACSA.2018.090938](https://www.researchgate.net/publication/327983469_Consequences_of_Customer_Engagement_in_Social_Networking_Sites_Employing_Fuzzy_Delphi_Technique_for_Validation/references)

N. A. M. Saffie, N. M. Shukor and K. A. Rasmani, "Fuzzy delphi method: Issues and challenges," 2016 International Conference on Logistics, Informatics and Service Sciences (LISS), Sydney, NSW, Australia, 2016, pp. 1-7, doi: [10.1109/LISS.2016.7854490](https://ieeexplore.ieee.org/document/7854490)

## Project Aim
To develop a flexible fuzzy Delphi module for the Jamovi statistical analysis platform that allows users to customize and refine the Delphi technique according to their own research needs and preferences.

## Module Installer for Different Jamovi Solid version

Jamovi version 2.3.28: [module](https://github.com/lerlerchan/FuzzyDelphiJmv/blob/main/version/FuzzyDelphiJmv_1.2.3.jmo)

Jamovi version 2.6.26: [module](https://github.com/lerlerchan/FuzzyDelphiJmv/blob/main/FuzzyDelphiJmv_1.0.0.jmo)

## Installation
Step-by-step images procedure can be view at
[Here](https://github.com/lerlerchan/FuzzyDelphiJmv/blob/main/tutorial/Installation_Procedure.pdf)

To install the Fuzzy Delphi module in [Jamovi](https://www.jamovi.org/download.html)  / [Jamovi v2.3.28](https://www.manageengine.com/products/desktop-central/software-installation/silent_install_Jamovi-(x64)-(2.3.28.0).html), follow these steps:

1. Click on the “+” icon in the top-right corner of Jamovi to access the module installation options.
2. Choose the Jamovi library from the menu that opens. OR download from [Here](https://github.com/lerlerchan/FuzzyDelphiJmv/blob/main/FuzzyDelphiJmv_1.0.0.jmo)

3. In the window that appears, click on “Available” (located at the top-middle).
4. Browse through the list of modules and click “INSTALL” for the Fuzzy Delphi module or any other module you’d like to use.
5. Finally, close the window by clicking the arrow pointing up in the top-right corner.
Once installed, you’ll be able to utilize the Fuzzy Delphi module for your
research needs and customize it according to your preferences

### Demonstration Video
https://github.com/lerlerchan/FuzzyDelphiJmv/assets/35757415/18fecf3e-896e-471d-b6e2-f104d035a70a

[![Watch the video](https://img.youtube.com/vi/)](https://www.youtube.com/embed/p-URv-m6NI0)

### Important Notes:
1. Name all your data header in "Item<number>". For Example: Item1, Item2,....
2. Sample data in .csv to experience can be download from [Here](https://github.com/lerlerchan/FuzzyDelphiJmv/tree/main/sampleData)

## Contributing
We are happy to receive bug reports, suggestions, questions, and (most of all) contributions to fix problems and add features. Pull Requests for contributions are encouraged.

Here are some simple ways in which you can contribute (in the increasing order of commitment):

- Read and correct any inconsistencies in the documentation
- Raise issues about bugs or wanted features
- Review code
- Add new functionality

## Issues we are solving
1. column header logic issue
2. bump chart for new ranking
3. cell highlighting function for fuzzy value more than 2.0
4. cell highlighting function for deffuzification less than 0.5
5. cell highlighting function for % <75%

## License

MIT License till 27 April 2024

GPL-v3 License updated on 28 April 2024

