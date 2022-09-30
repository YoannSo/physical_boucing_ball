public class MetricTree{
    
  int id=-1;
  
  MetricTree mtInside = null;
  MetricTree mtOutside = null;

  float radius;


  void insert(int newId, float r){
   // Racine de l'arbre
   if(this.id==-1){
      this.id= newId;
      this.radius=r;
      return;
   }
    //Cas générale
    PVector pos= balls.get(newId).position;
    PVector posId= balls.get(this.id).position;
    float d=dist(pos.x,pos.y,posId.x,posId.y);
    if(d<this.radius){
       if(this.mtInside==null){
        this.mtInside=new MetricTree();
      }
      this.mtInside.insert(newId,this.radius/2);
    }else{
      if(this.mtOutside==null){
        this.mtOutside=new MetricTree();
      }    
      this.mtOutside.insert(newId,this.radius);
    }
  }
  
  void search(PVector pos,IntList neighbours){
    // On suppose que l'arbre a bien été crée
    PVector posId= balls.get(this.id).position;
    float d=dist(pos.x,pos.y,posId.x,posId.y);
    
    if(d<h)
      neighbours.append(this.id);
    if(d<this.radius){
       if(this.mtInside!=null)  this.mtInside.search(pos,neighbours);
       if((this.mtOutside!=null)&&(d+h>this.radius))
          this.mtOutside.search(pos,neighbours);
    }
    else{
       if(this.mtOutside!=null)
           this.mtOutside.search(pos,neighbours);
       if((this.mtInside != null) && (d<this.radius+h))
           this.mtInside.search(pos,neighbours);

    
    }
  }
  
}
