public class GoToMyDashboardController {

	@AuraEnabled(cacheable=true)
	public static Map<String,String> getDashboard(String name){
		Map<String,String> mapToReturn = new Map<String,String>();
		mapToReturn.put('Id',name);
		mapToReturn.put('Title',name);
		try{
			List<Dashboard> dashboards = [SELECT Id,Title
			                              FROM Dashboard
			                              WHERE (Title = :name)
			                              ORDER BY LastModifiedDate DESC
			                              LIMIT 1];

			if(dashboards != null && dashboards.size() > 0) {
				mapToReturn.put('Id',dashboards.get(0).Id);
				mapToReturn.put('Title',dashboards.get(0).Title);
			}
			return mapToReturn;

		}
		catch(Exception e) {
			return mapToReturn;
		}

	}

}