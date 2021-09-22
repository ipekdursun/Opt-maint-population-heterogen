This decision support tool allows user to determine some distributional parameters and cost parameter and plots the structure of optimal policy and cost under given parameters. So it gives user an overview of the general actions through the lifespan of a system. This is done in ‘Parameter Selection’ of the tool. Please see Figure 1 for this tab. Without pressing to ‘Submit’ button on this tab, the other tabs do not work either. There are two plots in this tab: ‘Optimal Cost’ and ‘Optimal Action’.
For each belief and remaining lifespan, ‘Optimal Cost’ plot shows expected total cost until the end of lifespan of the system and ‘Optimal Action’ plot shows the optimal next planned maintenance time for that belief and remaining lifespan. 
<p align="center">
<img src=https://user-images.githubusercontent.com/41290925/134365719-23f04a1d-5f6d-4584-af6e-542c9d9a892e.png>
<br><br>
Figure 1: Parameter Selection Tab
</p>

The aim of these plots to show how general structure looks like under the current state space. Optimal cost and action for a specific belief and remaining lifespan is shown under ‘Decision Making’ tab.
‘Decision Making’ tab of the tool provides the next optimal replacement age and associated cost with that action under a given belief about the type of population and remaining lifespan of the system. You can see a view of tab in Figure 2.

<p align="center">
<img src=https://user-images.githubusercontent.com/41290925/134365757-702128fd-0681-433b-90c0-01c6da1c4972.png>
<br><br>
Figure 2: Decision Making Tab
</p>
First user selects a belief and remaining lifespan from the sliders under ‘States’ title. ‘Results’ section shows the following information: 

Optimal next planned maintenance time (time unit): This is the optimal time to schedule next planned replacement of the part under current belief and remaining lifespan of the system.

Expected next cycle cost (money unit): This is the expected cycle cost for next cycle under the state and optimal next planned maintenance time. 

Expected total cost until the end of lifespan (money unit): This is the expected total cost until the end of lifespan of the system starting from this remaining lifespan under the given belief and optimal next planned maintenance time. 
Also, after realization of a replacement, it is possible to update the belief and remaining lifespan of the system within the tool and query the next optimal action and associated cost according to updated state information. 
If you want to save an event realization (corrective or preventive replacement) you can save this by entering data to the ‘States’ and ‘Replacement Realization’ as an input then click to ‘Submit Observation’ button at the end.
You can see this data in a table under ‘Replacement History’ tab. In this table, the following fields are kept:

‘Belief’: Belief of components coming from a weak population after the previous replacement action (at the beginning of this replacement cycle)

Lifespan: Remaining lifespan of the system after the previous replacement action (at the beginning of this replacement cycle)

Action: Optimal action calculated by the model for one cycle ahead under ‘Belief’ and ‘Lifespan’ inputs.

Exp_total_Cost: Expected total cost calculated by the model under ‘Belief’ and ‘Lifespan’ inputs and ‘Action’ provided by the model.

Exp_cycle_Cost: Expected cost calculated by the model for one cycle ahead under ‘Belief’ and ‘Lifespan’ inputs and ‘Action’ provided by the model.

Replacement_type: Realized replacement after the last decision epoch. It can be either ‘preventive’ or ‘corrective’

Replacement_time: Real time passed since last replacement (decision epoch) until the time of this realized replacement.

Realized_cycle_cost: Real cost incurred according to the realized replacement. If a corrective replacement is observed, realized cycle cost is equal to 1. If a preventive replacement is observed, it is equal to the value entered at cost ratio in the parameter selection part. 

Updated_belief: Update of ‘Belief’ under ‘Replacement_time’ and ‘Replacement_type’ information. 

updated_lifespan: Update of ‘Lifespan’under ‘Replacement_time’.
It is possible to download or use this data for further analysis about the replacement activities or failure behavior. It can be downloaded in .csv or .Rdata format. The download formats can be tailored to the needs of user. 

