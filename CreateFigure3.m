%  CreateFigure3
%  -------------
%
%  Purpose - Code to play Mafia game with range of Mafia and Citizens,
%  -------   and games player.
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
%  ngames    - number of games
%  eta       - ratio of number of Mafia to number of Citizens
%  nm        - number of Mafia (nm = eta * sqrt( nr ) )
%  nc        - number of Citizens (nc = nr - nm)
%
%  Calling
%  -------
%  PlayMafia,  which calls
%  Daytime
%  Nightime
%
%  output
%  ------
%  On termintation a plot is displayed 
%
%  Notes
%  -----
%  1)  This analysis takes some time, using a AMD Ryzen 7 PRO 6850U it took
%      with current settings ~5660 seconds (94 minutes).
%
%  2)  To replicate the simulations in Braverman et al. (2009) set the
%      the simulation parameter ngames to 200.
%      Reference:  Braverman, M., Etesami, O., & Mossel, E. (2008)
%                  Mafia: A theoretical study of players and coalitions in
%                  a partial information environment.
%                  Annals of Applied Probability, 18, 825–846.
%
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
disp('CreateFigure3')
disp('-------------')
disp('If the number of games is high, it can take over and hour')
disp('for the code to complete its analysis.')
disp(' ')


%%%%%%%%%%%%%%%%%%%%%%%%
%                      %
%  initial conditions  %
%                      %
%%%%%%%%%%%%%%%%%%%%%%%%
nr = 10000;            %  number of Residents
ngames = 10000;        %  number of games  (target - 10,000)
eta = 0.01:0.05:5;     %  adjusts ratio of number of Mafia to number of Citizens
n = length( eta );     %  number of variations of number of Mafia and Citizens


%%%%%%%%%%%%%%%%%%
%                %
%  loop for eta  %
%                %
%%%%%%%%%%%%%%%%%%
for j=1:n
    nm = round( eta(j) * sqrt( nr) );     %  number of Mafia
    nc = nr - nm;                         %  number of Citizens


%%%%%%%%%%%%%%%%
%              %
%  play Mafia  %
%              %
%%%%%%%%%%%%%%%%
    MafiaWins = 0;
    CtzenWins = 0;
%
    for i=1:ngames
%   
        [ MWins, CWins ] = PlayMafia( nm, nc );
%
        MafiaWins = MafiaWins + MWins;
        CtzenWins = CtzenWins + CWins;
%
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         %
%  loop back to next eta  %
%                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PwinMafia(j) = ( MafiaWins ) / ( MafiaWins + CtzenWins );
end


%%%%%%%%%%%%%%%%%%%%%
%                   %
%  produce a graph  %
%                   %
%%%%%%%%%%%%%%%%%%%%%
figure(1)
%
plot( eta, PwinMafia, 'LineWidth', 2)
box off
xlabel('\eta','FontSize', 20,'FontWeight', 'Bold')
ylabel('P(Mafia)','FontSize', 18, 'FontWeight', 'Bold')
set( gca,'FontSize', 18, 'FontWeight', 'Bold')
xticks([ 0 1   2   3    4    5])
yticks([ 0 0.2 0.4 0.6, 0.8, 1])
axis([ 0 5 0 1])


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

