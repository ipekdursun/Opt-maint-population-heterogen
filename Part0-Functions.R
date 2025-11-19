#Functions
library(dplyr)
library(plyr)
library(foreach)

#Weibull cdf
F<-function(x,beta,alpha){
  x<-x-1
  return(1-exp(-((x+1)/beta)^alpha))
}
#Weibull pmf
f<-function(x,beta,alpha,incr=increment){
  x<-x-1
  return(exp(-((x)/beta)^alpha)-exp(-((x+1)/beta)^alpha))
}
m_cost_rate<-function(tau,p,z,beta_1,beta_2){
cp<-ifelse(round_any(tau,increment)==round_any(z,increment),0,C_p)
x<-seq(increment,tau,increment)
return(p*((C_f*F(tau,beta_1,alpha)+cp*(1-F(tau,beta_1,alpha)))/sum((1-F(x,beta_1,alpha))))+(1-p)*((C_f*F(tau,beta_2,alpha)+cp*(1-F(tau,beta_2,alpha)))/sum((1-F(x,beta_2,alpha)))))
}
cost_rate<-function(space){
  p=space[1]
  z=space[2]
  t=space[3]
  cp<-ifelse(round_any(t,increment)==round_any(z,increment),0,C_p)
  return(p*(C_f*F(t,beta_1,alpha)+cp*(1-F(t,beta_1,alpha)))+(1-p)*(C_f*F(t,beta_2,alpha)+(cp*(1-F(t,beta_2,alpha)))))
  }
update_p<-function(p,time,event,b_1=beta_1,b_2=beta_2){
    p_new=ifelse(round(event,1)==round(1,1),p*f(time,b_1,alpha)/(p*f(time,b_1,alpha) +(1-p)*f(time,b_2,alpha)), p*(1-F(time,b_1,alpha))/(p*(1-F(time,b_1,alpha))+(1-p)*(1-F(time,b_2,alpha))))
  p_new= ifelse(is.na(p_new),0,p_new)
    p_new=round_any(p_new,p_increment,f=ceiling)
  return(p_new)
  }

futurePM<-function(space)
{ p<-space[1]
t<-space[3]
return(p*(1-F(t,beta_1,alpha))+(1-p)*(1-F(t,beta_2,alpha)))
}
next_statePM<-function(space)
{p<-space[1]
z<-space[2]
t<-space[3]
return(which(round_any(states$Var1,p_increment)==update_p(p,t,0)&round_any(states$Var2,increment)==round_any(z-t,increment) )) 
}
next_stateCM<-function(space)
{p<-space[1]
z<-space[2]
x<-space[3]
return(which(round_any(states$Var1,p_increment)==update_p(p,x,1)&round_any(states$Var2,increment)==round_any(z-x,increment))) 
}
cont_int2<-function(t,p){
  temp_list<-round_any(seq(increment,t,increment),increment)
  idx<-unlist(lapply(temp_list, function(x){which(z_space==x)}))
  idx2<-unlist(lapply(temp_list, function(x){which(round_any(d_sub[,3],increment)==x)}))
  return(sum((p*future_cost2[idx]+ (1-p)*future_cost3[idx])*V_prime[d_sub[idx2,7]]))
}
cont_int<-cmpfun(cont_int2)

