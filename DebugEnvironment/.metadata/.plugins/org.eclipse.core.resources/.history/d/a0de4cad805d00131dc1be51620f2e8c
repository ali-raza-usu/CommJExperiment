package aspects;

import java.util.Date;
import joinpoints.communication.MultistepConversationJP;
import baseaspects.communication.MultistepConversationAspect;

public aspect PerfromanceTimeAspectMS extends MultistepConversationAspect {

	static String timingInfo = "";
	long startTime;
	private PerformanceMeasure pm = new PerformanceMeasure();

	before(MultistepConversationJP _multiStepJP): ConversationBegin(_multiStepJP){
		startTime =  new Date().getTime();
	}

	after(MultistepConversationJP _multiStepJP): ConversationEnd(_multiStepJP){
		long convEndTime = new Date().getTime();
		pm.updateRollingStatsWindow((double) (convEndTime - startTime));
		System.out.println(pm.printCurrentStats());
	}
}
