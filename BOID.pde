class BOID{

    float speed = 35; //50;
    int num = numpoints + 1;
    
    float goalx = random(width, height);
    float goaly = random(width, height);
    
    color c;
    
    

  
    float xP = 0; //50; 
    float yP = 0;//750; 
    float vx = 0; float vy= 0; float xAcc; float yAcc;
    //float[] arrayofXpoints = new float[num]; 
    //float[] arrayofYpoints = new float[num];

    
    
    //For BFS
    //array of booleans to determine if visited
    boolean visited[]  = new boolean[num]; 
    ArrayList<Integer>[] neighbors = new ArrayList[num];  //A list of neighbors can can be reached from a given node
    int[] parent = new  int[num];
    //To store the path
    ArrayList<Integer> path = new ArrayList(); 
    
    int nextNode; //keeps track of the next path
    
    boolean atEnd = false;

  
    BOID(float i_xp, float i_yp, float i_vx, float i_vy  ){
            
           xP = i_xp; yP = i_yp;
           //arrayofXpoints[0] = xP;
           //arrayofYpoints[0] = yP;
           
           //arrayofXpoints[num -1] = goalx;
           //arrayofYpoints[num - 1 ] = goaly;
           vx = i_vx;
           vy = i_vy;
        
        
      
      
           //for(int i = 1; i < num; i++)
           //{
           //  arrayofXpoints[i] = arrayx[i-1];
           //  arrayofYpoints[i] = arrayy[i-1];     
           //}
           //nextNode = path.size()-2;
    }
    
   void edges(){
    
     if(xP  > width){
         xP = 0;}
     else if(xP < 0){
         xP = width;}
         
     if(yP  > height){
         yP = 0;}
     else if(yP < 0){
         yP = height;}

    }
      
      //Implement BFS
      
      //void bfs() {
      //  //initialize the arrays to represent the graph
      //  for (int i = 0; i < num; i++)
      //  { 
      //    neighbors[i] = new ArrayList<Integer>(); 
      //    visited[i] = false;
      //    parent[i] = -1; //No partent yet
      //  }
        
      //  connect();
      //  println("List of Neghbors:");
      //  println(neighbors);
      
      //  int start = 0;
      //  int goal = num - 1;
      
      
      //  ArrayList<Integer> fringe = new ArrayList(); 
      //  println("\nBeginning Search");
      
      //  visited[start] = true;
      //  fringe.add(start);
      //  println("Adding node", start, "(start) to the fringe.");
      //  println(" Current Fring: ", fringe);
      
      //  while (fringe.size() > 0) {
      //    int currentNode = fringe.get(0);
      //    fringe.remove(0);
      //    if (currentNode == goal) {
      //      println("Goal found!");
      //      break;
      //    }
      //    for (int i = 0; i < neighbors[currentNode].size(); i++) {
      //      int neighborNode = neighbors[currentNode].get(i);
      //      if (!visited[neighborNode]) {
      //        visited[neighborNode] = true;
      //        parent[neighborNode] = currentNode;
      //        fringe.add(neighborNode);
      //        println("Added node", neighborNode, "to the fringe.");
      //        println(" Current Fringe: ", fringe);
      //      }
      //    }
      //  }
        
        
      //  print("\nReverse path: ");
      //  int prevNode = parent[goal];
      //  path.add(goal);
      //  print(goal, " ");
      //  while (prevNode >= 0) {
      //    print(prevNode, " ");
      //    path.add(prevNode);
      //    prevNode = parent[prevNode];
      //  }
      //  print("\n");
      //  println("The path is:");
      //  println(path);
      //  print("\n");
      //}
      
      
      
      void updateposit(float dt){
        
         float len = sqrt(vx*vx + vy*vy);
         
          
    
          
          vx = vx/len;
          vy = vy/len;
          
          xP += vx*speed*dt;
          yP += vy*speed*dt;
         
          vx += xAcc*dt;
          vy += yAcc*dt;
          
      }  
      
      //void updatevelocity(float dt, int count)
      ////void updateposit(float dt)
      //{
        
      //  if(count == -1){
          
      //    count = 0;
            
      //  }

         
      //  // Head to the first stop in the path
      //  if(count == path.size()-2 && count > 0)
      //  { 
          
      //    println(count);
      //    println(path.size());
      //    println(path);
      //    //vx = agent1.arrayofXpoints[agent1.path.get(count)] - agentxposit;
      //    //SOMETIMES CODE BREAKS HERE
      //    vx = arrayofXpoints[path.get(count)] - xP;
      //    //vy = agent1.arrayofYpoints[agent1.path.get(count)] - agentyposit;
      //    vy = arrayofYpoints[path.get(count)] - yP;
    
      //  }
      //  //check if we are close enough to head towards the next stop
      // if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 1 & count > 0)
      //  {  
      
      //     print("too close");
      //     vx = arrayofXpoints[path.get(count-1)] - xP;
      //     vy = arrayofXpoints[path.get(count-1)] - yP;
      //     //xP += vx*dt;
      //     //yP += vy*dt; 
      //     //if(count > 1 ){
      //       nextNode--;
      //     //}  
      //  }
       
      // //if(distance(agentxposit, agentyposit, xpoints[path.get(count)], ypoints[path.get(count)]) < 1 & count == 0 )
      // //check if near the gaol
      // if(count == 0)
      // {     
                  
             
      //   if(atEnd == false){
      //       vx = arrayofXpoints[path.get(count)] - xP;
      //       vy = arrayofYpoints[path.get(count)] - yP;
          
      //       ////xP += vx*dt;
      //       ////yP += vy*dt;
           
      //        if(distance(xP, yP, arrayofXpoints[path.get(count)], arrayofYpoints[path.get(count)]) < 25){
              
      //              atEnd = true;
               
      //             //vx = 0;
      //             //vx = 0;
                   
                                
      //               vx = random(-20, 20);
      //               vy = random(-20, 20);
               
      //         //xP += vx*dt;
      //         //yP += vy*dt;
      //       }
          
      //   }   
      //      //if(atEnd == true){
              
              
      //      //}  
      
    
      // }  
        
  
      
      //  println("The next node is:");
      //  println(nextNode);
      //  println(xP);
      //  println(yP);
      //}
      
      
      //void connect()
      //{
      
      //  for (int i = 0; i < num; i++)
      //  {
      
      //    float pocx;
      //    float pocy;
      //    pocx = arrayofXpoints[i] - xsphere;
      //    pocy = arrayofYpoints[i] - ysphere;
      
      
      
      //    float c; 
      //    c = (pocx*pocx) + (pocy*pocy) - (radius*radius);
      //    // This should avoid connecting with oneself and also checking twice for the same pair of points
         
      //    for ( int j = i+1; j < num; j++)
      //    {
      //      float vx;
      //      float vy;
      
      //      vx = arrayofXpoints[i] - arrayofXpoints[j];
      //      vy = arrayofYpoints[i] - arrayofYpoints[j];
      
      //      float a; 
      //      a = vx*vx + vy*vy;
      
      //      float b;
      //      b = (2*vx*pocx) + (2*vy*pocy);
      //      //checking for j = 2 should avoid connecting the agents
      //      if (sqrt(b*b - 4*a*c) > 0)
      //      {
      //      } 
      //      else
      //      {
      //        neighbors[i].add(j);
      //      }
      //    }
      //  }
      //}
      
      //float distance(float x, float y, float u, float v)

          
      

}//class
