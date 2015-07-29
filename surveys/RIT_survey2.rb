# -*- coding: utf-8 -*-
survey "RIT quality of life survey", :default_mandatory => true do

 section "Basic questions" do
    question "How old are you?", :pick => :one, :display_type => :dropdown
    a "17 or younger"
    a "18"
    a "19"
    a "20"
    a "21"
    a "22"
    a "23"
    a "24"
    a "25 or older"

    question "Describe yourself (Choose only one)", :pick => :one
    a "African American"
    a "White, not Hispanic"
    a "Hispanic, Latino/Latina"
    a "Asian or Pacific Islander"
    a "Middle Eastern descent"
    a "American Indian or Alaskan Native"
    a "Bi-racial/Multi-racial", :string
    a "Other", :string

    question "Work Status: (Choose only one)", :pick => :one
	a "Full-time (work 35 hours or more per week)"
	a "Part-time (work between 1-34 hours per week)"
	a "Not employed for pay"

    q_4 "Are you on Social Security Disability Insurance (SSDI) or Supplemental Security Income (SSI)? (Choose only one)", :pick => :one
	a "SSDI"
	a "SSI"
	a "None of the above"

    q_5 "Current relationship status: (Choose only one)", :pick => :one
	a "Single (not in a romantic relationship)"
	a "In a relationship (but NOT living with boyfriend or girlfriend)"
	a "In a relationship and living with boyfriend or girlfriend"
	a "Married"
	a "Separated (How long? (MM/YY))", :string
 	a "Divorced (How long? (MM/YY)", :string
   	a "Widowed"

    q_6 "Are you a _______________?", :pick => :one
	a "U.S. student"
	a "International student"
      	a "Community member (not a student)"
 end

 section "Hearing Status and Language" do
    q_7 "Are you ___________? (Choose only one)", :pick => :one
	a_1 "Deaf"
	a_2 "Hard of Hearing"
	a_3 "Hearing"


    q_8 "If deaf, how old were you when you became deaf? (Choose only one)", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
 	a "Deaf from birth"
	a "After birth, age:", :integer
	a "I do not know"

    q_7b "Do you have Usher’s Syndrome (US)?", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
        a "Yes"
        a "No" 
	a "I do not know"
    q_7c "Do you have Waardenburg Syndrome (WS)?", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
        a "Yes"
        a "No" 
	a "I do not know"

    q_7d "Do you have a cochlear implant (CI)?", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
      a_3 "Yes"
        a_4 "No" 

    q_7d1 "At what age did you receive the CI?"
    dependency :rule => "C"
    condition_C :q_7d, "==", :a_3
        a_1 "Age", :integer

     q_7d2 "Do you still use the CI?", :pick => :one
    dependency :rule => "C"
    condition_C :q_7d, "==", :a_3
        a_1 "Yes"
        a_2 "No" 
   
   q_10 "Which languages do you use? (Check all that apply)", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
	a "American Sign Language (ASL)"
	a "Signed English"
	a "Home Sign"
	a "Spoken English"
	a "Other:", :string

      q_11 "In which language are you most fluent? (Choose only one response)", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
	a "American Sign Language (ASL)"
	a "Spoken English"
	a "Both ASL & English (bilingual)"
	a "Other:", :string

      q_12 "How old did you start to learn ASL? (Choose only one)", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
	a "Birth"
	a "After birth, age:", :integer
	a "Never learned ASL"

      q_13 "How old did you start to learn Spoken English? (Choose only one)", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
	a "Birth"
	a "After birth, age:", :integer
	a "Never learned Spoken English"

      q_14 "How old did you start to learn written English?", :pick => :one
    dependency :rule => "A or B"
    condition_A :q_7, "==", :a_1
    condition_B :q_7, "==", :a_2
	a "Age:", :integer
    
    q_14b "Is anyone in your family deaf?", :pick => :one
    a_1 "Yes"
    a_2 "No"

      q_15 "Is your mother deaf?", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "Yes"
	a "No"


      q_16 "Is your father deaf?", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "Yes"
	a "No"

      q_17 "If your parents did not raise you, were you raised by other people (like an aunt or uncle)?", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
    	a_1 "Yes"
	a_2 "No"


     q_17b "Were they deaf ?", :pick => :one
     dependency :rule => "A"
     condition_A :q_17, "==", :a_1
	a_1 "Yes"
	a_2 "No"

    q_18 "Do you have brothers/sisters who are deaf?", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
    	a_1 "Yes"
	a_2 "No"
   
   repeater "Tell us about your deaf brothers. What are their ages?" do 
     dependency :rule => "A"
    condition_A :q_18, "==", :a_1
    q_18a1 "Age:"
      a :string
   end
   repeater "Tell us about your deaf sisters. What are their ages?" do 
    dependency :rule => "A"
    condition_A :q_18, "==", :a_1
    q_18b1 "Ages:"
      a :string
   end
    
   q_19 "Do you have any other deaf relatives (like aunt or uncle)?", :pick => :one
     dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
   	a_1 "Yes"
	a_2 "No"
    q_19a "Who?"
    dependency :rule => "A"
    condition_A :q_19, "==", :a_1
    a :string

   

  
     q_20a "Which do you prefer to use with each person?<br>...your mother? (Choose only one)", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "ASL"
	a "Signed English"
	a "Home Sign"
	a "Spoken English"
	a "Other:", :string

    q_20b "...your father? (Choose only one)", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "ASL"
	a "Signed English"
	a "Home Sign"
	a "Spoken English"
	a "Other:", :string

    q_20c "...your brothers and sisters? (Choose only one)", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "ASL"
	a "Signed English"
	a "Home Sign"
	a "Spoken English"
	a "Other:", :string
       	a "N/A (I do not have any brothers or sisters)"

     grid "Please rate the following statments (0 = Not At ALL to 10 = VERY MUCH.)" do
     dependency :rule => "A or B"
     condition_A :q_7, "==", :a_1
     condition_B :q_7, "==", :a_2
       a "0"
       a "1"
       a "2"
       a "3"
       a "4"
       a "5"
       a "6"
       a "7"
       a "8"
       a "9"
       a "10"
       q "As a person who is deaf or hard-of-hearing, I feel my parents give me the same amount of independence as others my age", :pick => :one
       q "I feel included in the things my family does together", :pick => :one
       q "As a person who is deaf or hard-of-hearing, I am satisfied with the ways I have to communicate", :pick => :one
       q "My mother understands everything I say.", :pick => :one
       q "I understand what my mother says.", :pick => :one
       q "My father understands everything I say.", :pick => :one
       q "I understand what my father says.", :pick => :one
     end
     q_21 "Which language do you communicate with your deaf friends? (Choose only one)", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "ASL"
	a "Signed English"
	a "Spoken English"
	a "Other:", :string
         a "N/A (I do not have any deaf friends)"

      q_22 "Which language do you communicate with your hearing friends? (Choose 
       only one)", :pick => :one
    dependency :rule => "E"
    condition_E :q_14b, "==", :a_1
	a "ASL"
	a "Signed English"
	a "Spoken English"
	a "Written English"
	a "Other:", :string
	a "N/A (I do not have any hearing friends)"

    
    q_23 "Describe your mother’s highest educational level? (Choose only one)", :pick => :one
        a "Elementary school"
	a "Middle School"
	a "Some High School"
	a "High School Graduate"
	a "GED"
	a "Some College"
	a "BA/BS Degree"
	a "Master’s Degree"
	a "Other Professional Graduate Degree (e.g., Ph.D., Ed.D., or M.D.)"
	a "I do not know"

     q_24 "Describe your father’s highest educational level? (Choose only one)", :pick => :one
	a "Elementary school"
	a "Middle School"
	a "Some High School"
	a "High School Graduate"
	a "GED"
	a "Some College"
	a "BA/BS Degree"
	a "Master’s Degree"
	a "Other Professional Graduate Degree (e.g., Ph.D., Ed.D., or M.D.)"
	a "I do not know"
    end
    section "Sexual Health Information" do
      q_25 "Did you take a seminar class on health and sexuality education for your freshman year at NTID/RIT?", :pick => :one
	a "Yes"
	a "No"
      

       q_26a "Have you ever had vagina sex?", :pick => :one
         a_y "Yes"
         a_n "No"

       q_26a1 "When you had vagina sex the first time how old were you?"
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y
         a :string

         q_27 "When you had vagina sex the first time did you use the following?", :pick => :any
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y
				  a "Birth Control Pill" 
				  a "Depo Provera"
				  a "NuvaRing"
				  a "IUD"
				a "Condom"
				a "Dental Dam"
				a "Withdrawal"
				a "Other: ", :string
      
      q_30 "Last six months you used condoms when having vagina sex?",:pick => :any
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y
        a "Always"
	a "Most of the time"
	a "Sometimes"
	a "Rarely"
	a "Never"

      q_30a "Last six months you used birth control when having vagina sex?",:pick => :any
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y
        a "Always"
	a "Most of the time"
	a "Sometimes"
	a "Rarely"
	a "Never"

       q_35 "With how many different partners have you ever had vagina intercourse?"
 	 a "# of Partners: ", :string
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y

        q_35a "In past year, how many partners you had vagina intercourse with?"
         a "# of Partners: ", :string
         dependency :rule => "A"
         condition_A :q_26a, "==", :a_y

	
	
        q_26b "Have you ever had oral sex?", :pick => :one
         a_y "Yes"
         a_n "No"

       q_26b1 "When you had oral sex the first time how old were you?"
         dependency :rule => "A"
         condition_A :q_26b, "==", :a_y
         a :string
 
         q_29 "When you had oral sex the first time did you use the following?",:pick => :any
         dependency :rule => "A"
         condition_A :q_26b, "==", :a_y
				  a "Birth Control Pill" 
				  a "Depo Provera"
				  a "NuvaRing"
				  a "IUD"
				a "Condom"
				a "Dental Dam"
				a "Withdrawal"
				a "Other: ", :string
       q_36 "With how many different partners have you ever had oral intercourse?"
         dependency :rule => "A"
         condition_A :q_26b, "==", :a_y
	a "# of Partners: ", :string

        q_36a "In past year, how many partners you had oral intercourse with?"
         a "# of Partners: ", :string
         dependency :rule => "A"
         condition_A :q_26b, "==", :a_y

       q_33 "Last six months you used Dental Dam when having oral sex?",:pick => :any
         dependency :rule => "A"
         condition_A :q_26b, "==", :a_y
	a "Always"
	a "Most of the time"
	a "Sometimes"
	a "Rarely"
	a "Never"

       q_26c "Have you ever had anal or asshole sex?", :pick => :one
         a_y "Yes"
         a_n "No"

       q_26c1 "When you had anal or asshole sex the first time how old were you?"
         dependency :rule => "A"
         condition_A :q_26c, "==", :a_y
         a :string
 

        q_28 "When you had anal or asshole sex the first time did you use the following?", :pick => :any
         dependency :rule => "A"
         condition_A :q_26c, "==", :a_y
 				  a "Birth Control Pill" 
				  a "Depo Provera"
				  a "NuvaRing"
				  a "IUD"
				a "Condom"
				a "Dental Dam"
				a "Withdrawal"
				a "Other: ", :string
      
       q_38 "With how many different partners have you ever had anal or asshole intercourse?"
         dependency :rule => "A"
         condition_A :q_26c, "==", :a_y
	a "# of Partners: ", :string

       q_39 "In past year, how many different partners you have anal or asshole intercourse with?"
         dependency :rule => "A"
         condition_A :q_26c, "==", :a_y
	 a "# of Partners: ", :string


     q_32   "Last six months you used condoms when having anal or asshole sex?",:pick => :any
        dependency :rule => "A"
         condition_A :q_26c, "==", :a_y
	a "Always"
	a "Most of the time"
	a "Sometimes"
	a "Rarely"
	a "Never"

       q_26d "Have you ever had sex in any way other than vagina, oral, or anal (asshole)?", :pick => :one
         a_y "Yes"
         a_n "No"

       q_26d1 "What is this other sex act called?"
         dependency :rule => "A"
         condition_A :q_26d, "==", :a_y
         a :string

       q_26d2 "When you had this other sex act the first time, how old were you?"
         dependency :rule => "A"
         condition_A :q_26d, "==", :a_y
         a :string


      
 

       q_34 "Do you use any of the following?",:pick => :any
				  a "Birth Control Pill" 
				  a "Depo Provera"
				  a "NuvaRing"
				  a "IUD"
				a "Condom"
				a "Dental Dam"
				a "Withdrawal"
				a "Other: ", :string

     q_34b "Are you male or female?", :pick => :one
       a_m "Male"
       a_f "Female"

       q_40 "Have you ever gotten a woman pregnant?", :pick => :one
         dependency :rule => "A"
         condition_A :q_34b, "==", :a_m
	a "No"
	a "Yes: How many times?" , :string
       
       q_41 "Have you become pregnant before?", :pick => :one
         dependency :rule => "A"
         condition_A :q_34b, "==", :a_f
	a "No"
	a_yes "Yes: How many times?" , :string
       
  
      q_41a "How old were you the first time you became pregnant?"
    dependency :rule => "E"
    condition_E :q_41, "==", :a_yes
         a "Age: ", :string

      q_41b "With first pregnancy- you plan to get pregnant?", :pick => :one
    dependency :rule => "E"
    condition_E :q_41, "==", :a_yes
	 a "Yes"
	 a "No"
	 a "Didn’t Care"

      q_41c "Have you had an abortion?", :pick => :one
    dependency :rule => "E"
    condition_E :q_41, "==", :a_yes
         a "No"
	 a "Yes: How many? ", :string

      q_41d "Do you have kids?", :pick => :one
	a "No"
         a "Yes, biological: How many? ", :string
         a "Yes, adopted: How many? ", :string

      q_42 "You ever get an infection or disease because you had sex?", :pick => :one
	a "No"
	a_yes "Yes"

      
        q_42a "How many times did you have an STI or STD?"
      dependency :rule => "E"
      condition_E :q_42, "==", :a_yes
          a :string
        q_42b "When was the most recent time you had an STI or STD?"
      dependency :rule => "E"
      condition_E :q_42, "==", :a_yes
          a "Year ", :string
          a "Month ", :string
      

     q_43 "Did your doctor tell you that you have HIV/AIDS?", :pick => :one
	 a "No"
	 a "Yes"

     q_44 "Are you worried that you are at risk for HIV/AIDS?", :pick => :one
	 a "No"
	 a "Yes"

     q_45 "Did your doctor tell you that you have Hepatitis C?", :pick => :one
	 a "No"
	 a "Yes"
   end
  section "Social Media Use" do
    grid "Which social networks do you check?" do
      a "Hourly"
      a "Daily"
      a "Weekly"
      a "Monthly"
      a "Every Several Months"
      a "Never"
      q "SMS (Cell phone text)", :pick => :one
      q "Facebook", :pick => :one
      q "Twitter", :pick => :one
      q "Google+", :pick => :one
      q "LinkedIn", :pick => :one
      q "Foursquare", :pick => :one
      q "Pinterest", :pick => :one
      q "Instagram", :pick => :one
      q "Tumblr", :pick => :one
      q "Flickr", :pick => :one
      q "Meetup", :pick => :one
      q "Plenty of Fish", :pick => :one
      q "Vine", :pick => :one
      q "Snapchat", :pick => :one
      q "Reddit", :pick => :one
      q "Match.com", :pick => :one
      q "Zoosk", :pick => :one
      q "Okcupid", :pick => :one
      q "Badoo", :pick => :one
      q "Jab", :pick => :one
      q "Other", :pick => :one
    end
    grid "Choose any device (e.g., pager) you use for social networking" do
      a "Hourly"
      a "Daily"
      a "Weekly"
      a "Monthly"
      a "Every Several Months"
      a "Never"
      q "Android",  :pick => :one
      q "IPhone", :pick => :one
      q "Blackberry", :pick => :one
      q "Apple Ipad", :pick => :one
      q "Apple Laptop", :pick => :one
      q "Windows Laptop", :pick => :one
      q "Linux Laptop", :pick => :one
      q "Apple Desktop", :pick => :one
      q "Windows Desktop", :pick => :one
      q "Linux Desktop", :pick => :one
      q "Other (please specify)", :pick => :one
     end
     grid "Please rate the following statements (1 = strongly disagree to 5 = strongly agree.)" do
     a "1"
     a "2"
     a "3"
     a "4"
     a "5"
     q "I use Facebook every day", :pick => :one
     q "I tell people I am on Facebook often", :pick => :one
     q "Facebook is part of my daily routine now", :pick => :one
     q "I feel out of touch when I haven't logged onto Facebook for a while", :pick => :one 
     q "If I use Facebook, I feel part of the community.", :pick => :one
     q "If Facebook is shut down, I would be sad", :pick => :one
     q "I have used Facebook to look at someone I met socially", :pick => :one
     q "I use Facebook to learn more about other people in my classes", :pick => :one
     q "I use Facebook to learn more about other people living near me", :pick => :one 
     q "I use Facebook to keep in touch with my old friends", :pick => :one
     q "I use Facebook to meet new people", :pick => :one
     q "I use Facebook to get advice about something I want to buy", :pick => :one
     q "I use Facebook to get business referrals", :pick => :one
     q "I use Facebook to get answers to specific questions", :pick => :one
     q "I use Facebook to ask questions about health issues", :pick => :one
     q "I feel like a person equal, like other people", :pick => :one
     q "I feel that I’m a person of worth, at least on an equal plane with others", :pick => :one
     q "I feel that I have many good qualities", :pick => :one
     q "I often feel that I am a failure", :pick => :one
     q "I am able to do things pretty well like most other people", :pick => :one
     q "I feel I do not have much to be proud of", :pick => :one
     q "I have a positive attitude about myself", :pick => :one
     q "I am happy with myself", :pick => :one

     q "In most ways my life at NTID (RIT) is close to my ideal.", :pick => :one
     q "My life at NTID (RIT) is excellent.", :pick => :one
     q "I am happy with my life at NTID (RIT).", :pick => :one
     q "I have gotten important things I want at NTID (RIT).", :pick => :one
     q "If I could live my time at NTID (RIT) over, I would not change anything.", :pick => :one

     q "I feel I am part of the NTID (RIT) community", :pick => :one
     q "I am interested in what goes on at NITD (RIT)", :pick => :one
     q "NTID (RIT) is a good place to be", :pick => :one
     q "I would be willing to give money to NTID (RIT) after graduation", :pick => :one
     q "Socializing with people at NTID (RIT) makes me want to try new things", :pick => :one
     q "Socializing with people  at NTID (RIT) makes me feel like a part of a community", :pick => :one
     q "I am willing to spend time to support general NTID (RIT) activities", :pick => :one 
     q "At NTID (RIT), I meet new people all the time", :pick => :one
     q "Socializing with people at NTID (RIT) means that everyone in the world is connected", :pick => :one

     q "There are several people at NTID (RIT) I trust to help solve my problems", :pick => :one
     q "If I needed an emergency loan of $100, I know someone at NTID (RIT) who can give money to me", :pick => :one
     q "At NTID (RIT) I can ask for advice about making very important decisions", :pick => :one
     q "The people I hang out with at NTID (RIT) will give me good job references", :pick => :one
     q "I do not know people at NTID (RIT) well enough to get them to do anything important for me", :pick => :one

     q "I’d be able to find out about events in another town from a high school acquaintance living there", :pick => :one
     q "If I needed to, I could ask a high school friend to do a small favor for me", :pick => :one
     q "I could stay with a high school friend if traveling to a different city", :pick => :one
     q "I could find information about a job or internship from a high school friend", :pick => :one
     q "It would be easy to find people and invite them to my high school reunion", :pick => :one
    end
    end
end
    

