public class CreateGrades {

    public static void createGradesForEnrollment(List<ClassEnrollment__c> newClassEnrollments){
        /*System.debug('Starting trigger');
		//Step1 : extract Students and classes they're in from classEnrollments
		List<Id> newStudentsIds = new List<Id>();
        List<Id> newClassesIds = new List<Id>();
        for(ClassEnrollment__c newClassEnrollment: newClassEnrollments){
            newStudentsIds.add(newClassEnrollment.Student__c);
            newClassesIds.add(newClassEnrollment.Class__c);
        }
        
        //Step2: figure out which assessments each class has
        Map<Id, List<Assessment__c>> assessmentToClass = new Map<Id, List<Assessment__c>>();
        List<Id> newAssessments = new List<Id>();
        for(Assessment__c newAssessment: [SELECT Class__c  FROM Assessment__c WHERE Class__c in :newClassesIds]){
			List<Assessment__c> newListAssessments = assessmentToClass.get(newAssessment.Class__c);
            try{
                newListAssessments.add(newAssessment);
            } catch (Exception e){
                newListAssessments = new List<Assessment__c>();
            }
            assessmentToClass.put(newAssessment.Class__c, newListAssessments);
            newAssessments.add(newAssessment.Id);
        }
        
        //Step 3: Figure out which grades go with each assessment
        Map<Id, List<Grade__c>> gradeToAssessments = new Map<Id, List<Grade__c>>();
        //List<Grade__c> newGrades = new List<Grade__c>();
        for(Grade__c newGrade: [SELECT Assessment__c FROM Grade__c WHERE Assessment__c in:newAssessments]){
            List<Grade__c> newListGradess = gradeToAssessments.get(newGrade.Assessment__c);
            try{
                newListGradess.add(newGrade);
            } catch(Exception e){
				newListGradess = new List<Grade__c>();
            }            
            gradeToAssessments.put(newGrade.Assessment__c, newListGradess);
           // newGrades.add(newGrade);
        }
        
        //Step 4: Check if the student being added in has any grades without a score
        List<Grade__c> gradesToBeAdded = new List<Grade__c>();
        for(ClassEnrollment__c newClassEnrollment: newClassEnrollments){
            Id ClassId = newClassEnrollment.Class__c;
            //The for loop below is null or something
            try{
                for(Assessment__c newListAssessment: assessmentToClass.get(ClassId)){
                    boolean foundGrade = false;
                    for(Grade__c newListGrade: gradeToAssessments.get(newListAssessment.Id)){
                        if(newListGrade.Class_Enrollment__c == newClassEnrollment.Id){
                            foundGrade = true;
                        }
                    }
                    if(!foundGrade){
                        Grade__c newGrade = new Grade__c(Assessment__c = newListAssessment.Id, Class_Enrollment__c = newClassEnrollment.Id, Grade__c = 0.0);
                        gradesToBeAdded.add(newGrade);
                    }
                }
            } catch(Exception e){
                System.debug('Class with no assignments *shrug*');
            }
        }
        
        System.debug('The gardes to be add are: ' + gradesToBeAdded);
        insert gradesToBeAdded;
        System.debug('Ending trigger');
*/
        List<Id> classIds = new List<Id>();
        for(ClassEnrollment__c ce : newClassEnrollments){
            classIds.add(ce.Class__c);
        }
        
        List<Grade__c> gradesToInsert = new List<Grade__c>();
        //List<Assessment__c> assessments = [SELECT Id, Class__c FROM Assessment__c WHERE Class__c IN : classIds];
        
        for(Assessment__c assmt : [SELECT Id, Class__c FROM Assessment__c WHERE Class__c IN : classIds]){
            for(ClassEnrollment__c ce : newClassEnrollments){
                if(ce.Class__c == assmt.Class__c){
                    Grade__c g = new Grade__c();
                    g.Assessment__c = assmt.id;
                    g.Class_Enrollment__c = ce.id;
                    gradesToInsert.add(g);
                }
            }
        }
        insert gradesToInsert;
    }
    
    public static void createGradeForAllStudentsInAssessment(List<Assessment__c> newAssessments){
		//Step1: get list of classes
		List<Id> classIds = new List<Id>();
        for(Assessment__c newAssessment: newAssessments){
            classIds.add(newAssessment.Class__c);
        }
		//Step2: get list of Class enrollments
		List<ClassEnrollment__c> classEnrollments = [SELECT Class__c, Student__c FROM ClassEnrollment__c WHERE Class__c IN : classIds];
        //Step3: create the grade records
        List<Grade__c> newGrades = new List<Grade__c>();
        for(Assessment__c newAssessment: newAssessments){
            for(ClassEnrollment__c CE : classEnrollments){
            	Grade__c g = new Grade__c();
            	g.Assessment__c = newAssessment.Id;
                g.Class_Enrollment__c = CE.Id;
                g.Grade__c = 0.0;
                newGrades.add(g);
        	}
        }
        insert newGrades;
    }
    
    public static void preventDuplicates(List<Grade__c> newGrades){
        //Step 1: get list of assessments
        List<Id> assessmentIds = new List<Id>();
        for(Grade__c grade : newGrades){
            assessmentIds.add(grade.Assessment__c);
        }
        List<Assessment__c> newAssessments = [SELECT Id, Name FROM Assessment__c WHERE Id in :assessmentIds];
        //Step 2: get list of grades already created for those assessments
        List<Grade__c> oldGrades = [SELECT Id, Assessment__c FROM Grade__c WHERE Assessment__c in :assessmentIds];
        map<Grade__c, Id> gradeToAssessmentId = new Map<Grade__c, Id>();
        for(Grade__c grade : oldGrades){
            gradeToAssessmentId.put(grade, grade.Assessment__c);
        }
        //Step 3: check for the duplicates and mark them with error
        for(Grade__c grade : newGrades){
            Id nullChecker = gradeToAssessmentId.get(grade);
            if(nullChecker != null){
                grade.addError('ERROR: There is already an Identical Record: ' + grade.Id);
            }
        }
    }
    
    /*
     *  public static void setStudentGrades(list<Assessment__c> listAssessments){
       // Go through the Assessments class
       // Store the class id for each assessment in a list
       list<id> assessClass = new list<id>();
       for(Assessment__c listAssessment : listAssessments){
           assessClass.add(listAssessment.Class__c);
       }

       // from the list of class Id's grab the class enrollments
      for(ClassEnrollment__c classEnrollment : [SELECT Id, Class__c, Student__c
                                                 FROM ClassEnrollment__c
                                                 WHERE Class__c in : assessClass]){
            for(Assessment__c listAssessment : listAssessments){
               if(classEnrollment.Class__c == listAssessment.Class__c){
                   //assign the new grades
                   /*
                    * INSERT THINGS HERE
                    *             
               }
           }
       }


   } 
     */
    
    public static void preventDuplicateClassEnrollments(){
        
    }
    
    public static void preventDuplicateClasses(){
        
    }
}