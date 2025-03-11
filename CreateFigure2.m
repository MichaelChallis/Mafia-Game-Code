%  CreateFigure2
%  -------------
%
%  Purpose - Code to demonstrate determininistic model of Mafia winning
%  -------   with Braverman Strategy, and Modified Braverman Stratergy.
%
%  Date - 03/11/2025
%  ----
%
%  Author - M J Challis
%  ------
%
%  Key Variables
%  -------------
%  nr        - number of Residents
%  nm        - number of Mafia
%  nc        - number of Citizens (nc = nr - nm)
%  Pbs       - probability of win with Braverman et al. (2009) strategy
%  Pmbs      - probability of win with modified Braverman strategy
%
%  output
%  ------
%  On termintation a plot is displayed. 
%
%  Notes
%  -----
%  1)  This analysis computes the performance of Braverman et al. (2009)
%      strategy for playing the game Mafia, and also computes the superior
%      Modified Braverman Strategy.
%
%  2)  The work of Braverman et al. (2009) is described in,
%                  Braverman, M., Etesami, O., & Mossel, E. (2008)
%                  Mafia: A theoretical study of players and coalitions in
%                  a partial information environment.
%                  Annals of Applied Probability, 18, 825–846.
%
%  3)  The Modified Braverman Stratgey in described in the pre-print,
%                  Challis, M.J. (2025)
%                  Revised theory and modeling of the the Optimal
%                  strategies in the game Mafia.
%


%%%%%%%%%%%%%
%           %
%  tidy-up  %
%           %
%%%%%%%%%%%%%
clear all
clc
clf


%%%%%%%%%%%%%%%%%%
%                %
%  introduction  %
%                %
%%%%%%%%%%%%%%%%%%
disp('CreateFigure2')
disp('-------------')


%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
%  initial conditions  %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%
nr = (2:1:48)';                  %  set of number of Residents (2 to 48)
nm = ones(size( nr) );           %  set of number of Mafia (fixed at 1)
nc = nr - nm;                    %  set of number of Citizens (1 to 47)
n = length( nr );                %  amount of data


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                       %
%  set of probabilities, Mafia          %
%  (needed for subsequent calculations  %
%                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pm(1) = nc(1) / nr(1);                  %  Mafia probability
Pm(2) = nc(2) / nr(2);
%
for i=3:n
    Pm(i) = ( nc(i) / nr(i) ) * Pm(i-2);
end


%%%%%%%%%%%%%%%%%%%%%%
%                    %
%  final conditions  %
%                    %
%%%%%%%%%%%%%%%%%%%%%%
clear nr nm nc n
nr = (4:1:50)';                  %  set of number of Residents (4 to 50)
nm = 2 * ones(size( nr) );       %  set of number of Mafia (fixed at 2)
nc = nr - nm;                    %  set of number of Citizens (2 to 48)
n = length( nr );                %  amount of data


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                        %
%  set of probabilities for modified Braverman strategy  %
%                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pmbs(1) = ( nm(1) / nr(1) )...                           %  Mafia probability
        + ( nc(1) / nr(1) )...
        * ( (1/2) + (1/2) * Pm(1) );
%
Pmbs(2) = (   nc(2) / nr(2) )...
        + ( ( nm(2) / nr(2) )...
        *  Pm(2) );
%
for i=3:n
    Pmbs(i) = ( ( nc(i) / nr(i) ) * Pmbs(i-2) )...
            + ( ( nm(i) / nr(i) ) * Pm(i)   );
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                    %
%  set of probabilities for Braverman Strategy (bs)  %
%                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pbs(1) = ( 1 / 2 ) + ( 1 / 2 ) * ( 1 - Pm(1) );      %  Mafia Probability
%
Pbs(2) =   ( nc(2) / nr(2) )...
       + ( ( nm(2) / nr(2) )...
       * Pm(2) );
%
for i=3:n
    Pbs(i) = ( nc(i) / nr(i) ) * ( 1 - Pbs(i-2) )...
           + ( nm(i) / nr(i) ) * ( 1 - Pm(i) );
    Pbs(i) = 1 - Pbs(i);
end


%%%%%%%%%%%%%%%%%%%%%
%                   %
%  produce a graph  %
%                   %
%%%%%%%%%%%%%%%%%%%%%
figure(1)
%
plot( nr(1:2:end), Pmbs(1:2:end), 'b', nr(1:2:end), Pbs(1:2:end), 'r:', 'LineWidth', 2)
box off
xlabel('Number of Residents','FontSize', 20,'FontWeight', 'Bold')
ylabel('P(Mafia)','FontSize', 18, 'FontWeight', 'Bold')
legend('MBS', 'BS')
legend('boxoff')                                                     %  removes box from legend
set( gca,'FontSize', 18, 'FontWeight', 'Bold')
xticks([ 10   20   30    40    50])
yticks([ 0 0.2 0.4 0.6, 0.8, 1])
axis([ 0 50 0 1])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            %
%  make noise when finished  %
%                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beep


%
%%
%%%The End%%%
%%
%
