
library(dplyr)
library(plyr)
library(data.table)

future_cost2_2<-rev(future_cost2)[-1]
future_cost3_2<-rev(future_cost3)[-1]
states<-data.frame(states)

end_life<-states[states[,2]==0 ,]
end_ind<-which(states[,2]==0)
iter_states<-which(states[,2]!=0)
data_space<-data.table(data_space)
colnames(data_space)[1:3]<-c("Var1", "Var2","Action")
setkey(data_space,Var1,Var2)


#Optimal Policy

iter_Funct<-function(s,z){
  p<-states[s,1]
  assign("d_sub",data_space[.(p,z),], envir = .GlobalEnv)
  tempQ<-d_sub$immediate_cost+unlist(mclapply(d_sub$Action,function(t){cont_int(t,p)}))+ V_prime[d_sub$nextPMstate]*d_sub$future_pm
  V_prime[s]<-min(tempQ) #check whether you need to return them or not
  tau[s]<-which.min(tempQ)
  return(c(V_prime[s],tau[s]))
  
}

V_prime<-rep(0,nrow(states)) 
tau<-rep(0,nrow(states))

z_temp<-1
while (z_temp<(L+1)){
  iter_id<-which(round(states$Var2)==round(z_temp))
  result<-mapply(iter_Funct,s=iter_id,z=z_temp)
  V_prime[iter_id]<-result[1,]
  tau[iter_id]<-result[2,]
  z_temp<-z_temp+1
}
proposed_results<-cbind(states,V_prime,tau)



overall_summary<-cbind(L,C_p,alpha, c(0.25,0.5,0.75), 
                       rbind(proposed_results[proposed_results$Var1==0.25&proposed_results$Var2==L,3],
                             proposed_results[proposed_results$Var1==0.5&proposed_results$Var2==L,3],
                             proposed_results[proposed_results$Var1==0.75&proposed_results$Var2==L,3]),
                      )
colnames(overall_summary)<-c("L",'C_p','shape',"p","MP",'TP',"PP",'threshold')

overall_summary


