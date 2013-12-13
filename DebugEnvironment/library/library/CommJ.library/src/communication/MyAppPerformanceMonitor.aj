package communication;
import java.util.*;

import baseaspects.communication.MultistepConversationAspect;

import joinpoints.communication.MultistepConversationJP;


public aspect MyAppPerformanceMonitor extends TotalTurnAroundTimeMonitor{

        public MyAppPerformanceMonitor() {
		super();
		// TODO Auto-generated constructor stub
	}

		private ArrayList<Stats> statsList = new ArrayList(11);
        private int currentStatsIndex = 0;
        
        @Override
		public void End(MultistepConversationJP jp)
        {
                // Get number of elapsed minutes since beginning of current stats, but now mor
                long elapsedMinutes = Math.min(statsList.get(currentStatsIndex).getMinutesSinceStartTime(), 10);

                // Roll stats window forward, if necessary
                for (int i=0; i<elapsedMinutes; i++)
                {
                        currentStatsIndex++;
                        if (currentStatsIndex>10)
                                currentStatsIndex=0;
                        statsList.get(currentStatsIndex).Reset();
                        //Do we really need this line
                        statsList.get(currentStatsIndex).addCompleteConversation(getTurnAroundTime());
                        
                }

                //This line was written by Dr. Clyde
                //statsList.addCompleteConversation(getTurnAroundTime());
        }
}

class Stats{
        private long startTime;
        private int completeConvCount;
        private double avgTurnaroundTime;

        public Stats() {
                Reset();
        }

        public void Reset() {
                startTime = System.currentTimeMillis();
                completeConvCount = 0;
                avgTurnaroundTime = 0;
        }
        public long getMinutesSinceStartTime() {
                // using the current time, compute and return the number of minutes since the
                // start time of this stats object. A zero means we still in the same minute
        	return 0;
        }

        public void addCompleteConversation(double newTurnaroundTime){
                avgTurnaroundTime = ((completeConvCount*avgTurnaroundTime) + newTurnaroundTime)/(++completeConvCount);
        }

        public int getCompleteConvCount(){
                return completeConvCount;
        }

        public double getAvgTurnaroundTime(){
                return avgTurnaroundTime;
        }
}
