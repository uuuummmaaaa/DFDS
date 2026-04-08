# DFDS Implementation code
Implementation code for 'Depth-first directional search for nonconvex optimization'

## Project Structure
main.m​ - Main experiment script.

preliminary.m​ - Preliminary test script.

ackley.m​, levy.m, alpine.m, six_hump.m, goldstein_price.m - Benchmark optimization functions.

dfds.m, ihr.m, prs.m​ - Optimization algorithm implementations.

## Running the Experiments

### Preliminary Tests 
**Open preliminary.m**

**Locate the "PROBLEM SETUP" section and modify the following parameters** for different experimental setups:
- N: problem dimension,
- MaxEval: function evaluation budget.
- R: the step size distance parameter $R_\epsilon$ in DFDS.

**Output:** The statistics of 
$f_\text{best}-f^* $ 
and 
$||x_\text{best} - x^*||$ 
of all algorithms under the preset parameters will be displayed as output.
  
**Run preliminary.m​** to obtain results in Table 1-3.

### Main Experiments
**Open main.m**

**Locate the "PROBLEM SETUP" section** 
- Uncomment the code block for your target function.
- Comment out the code blocks for other functions.
- Modify N for different problem dimension setups.

**Output:** The success rates of all algorithms under the target function and dimension settings will be displayed as output.

**Run main.m​** to obtain results in Table 5-8.
  
