library(dplyr)
library(plyr)
library(foreach)
library(data.table)
#Part A
#generating States 
L=200
increment=1
p_increment<-0.00005
z_space<-round_any(seq(from=L,to=0,by=-increment),increment)
p_space<-round_any(seq(from=0,by=p_increment,to=1),p_increment)
states<-expand.grid(p_space,z_space)




end_life<-states[states[,2]==0 ,]
end_ind<-which(states[,2]==0)
iter_states<-which(states[,2]!=0)

data_space<-data.table()
data_sp<-function(s){ 
  p<-states[s,1]
  z<-states[s,2]
  temp_space<-cbind(Var1=rep(p,z),Var2=rep(z,z),Var3=1:z) 
}
dat=lapply(iter_states,data_sp)
data_space=do.call(rbind,dat)

data_space<-as.matrix(data_space)

save.image(file='data_space.Rdata')

#Part B
#Generating state transition data based on time-to-failure dist.

#Discrete Weibull Distribution parameters
alpha=5 #Shape parameter
beta_1=10 #Scale parameter for weak population
beta_2=20 #Scale parameter for strong population

source(file = 'Functions.R')
data_space<-as.matrix(data_space)


future_cost2<-f(z_space,beta_1,alpha)
future_cost3<-f(z_space,beta_2,alpha)

future_pm<-apply(data_space,1,futurePM)
update_p_1<-function(space){
  p<-space[1]
  time<-space[3]
  p_new=p*(1-F(time,beta_1,alpha))/(p*(1-F(time,beta_1,alpha))+(1-p)*(1-F(time,beta_2,alpha)))
  p_new= ifelse(is.na(p_new),0,p_new)
  p_new=round_any(p_new,p_increment,f=ceiling)
}

update_p_2<-function(space){
  p<-space[1]
  time<-space[3]
  p_new=p*f(time,beta_1,alpha)/(p*f(time,beta_1,alpha) +(1-p)*f(time,beta_2,alpha))
  p_new= ifelse(is.na(p_new),0,p_new)
  p_new=round_any(p_new,p_increment,f=ceiling)
}
PM_next_p<-apply(data_space,1,update_p_1)
CM_next_p<-apply(data_space,1,update_p_2)
next_z<-data_space[,2]-data_space[,3]
states<-data.table(states)
nextPMstate_2<-function(s){
  p<-round_any(PM_next_p[s],p_increment)
  z<-next_z[s]
  setkey(states,Var1,Var2)
  return(states[.(p,z),which=T])
}
nextCMstate_2<-function(s){
  p<-round_any(CM_next_p[s],p_increment)
  z<-next_z[s]
  setkey(states,Var1,Var2)
  return(states[.(p,z),which=T])
}
nextPMstate<-nextPMstate_2(1:nrow(data_space))
nextCMstate<-nextCMstate_2(1:nrow(data_space))



save.image(file=paste0('data_space_2_',L,"_",alpha,'.Rdata'))
#Part C: Generating immediate cost data with given costs parameters
C_f=1 #Corrective maintenance cost
C_p=0.1 #Preventive maintenance cost. You can change this parameter as you wish

data_space<-data.table(data_space)
data_space[,cp:=ifelse(Var2==Var3,0,C_p)]
data_space[,immediate_cost:=Var1*(F(Var3,beta_1,alpha)+cp*(1-F(Var3,beta_1,alpha)))+(1-Var1)*(F(Var3,beta_2,alpha)+(cp*(1-F(Var3,beta_2,alpha))))]
data_space[,cp:=NULL]

data_space<-cbind(data_space,future_pm,nextPMstate,nextCMstate)
names(data_space)[1:3]<-c("p","z","t")

gc()


