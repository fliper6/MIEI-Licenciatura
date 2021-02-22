import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;


public class FBFeed {
    private List<Ex4FBPost> posts;

    public FBFeed ()
    { this.posts = new ArrayList<>(); }

    public FBFeed (List<Ex4FBPost> posts) {
        this.posts = new ArrayList<>();
        for (Ex4FBPost f: posts)
            this.posts.add(f.clone());
    }

    public FBFeed (FBFeed f)
    { setPosts (f.getPosts());}

    public List<Ex4FBPost> getPosts() {
        List <Ex4FBPost> fbp = new ArrayList<>();
        for(Ex4FBPost p : this.posts) {
            fbp.add(p.clone());
        }
        return fbp;
    }

    public void setPosts (List<Ex4FBPost> f) {
        this.posts = new ArrayList<>();
        for (Ex4FBPost p: f)
            this.posts.add(p.clone());
    }

    public int nrPosts (String user) {
        return (int) this.posts.stream()
                         .filter(p -> p.getUsername().equals(user))
                         .count();
    }

    public List<Ex4FBPost> postsOf (String user) {
        return  this.posts.stream()
                    .filter(p -> p.getUsername().equals(user))
                    .collect(Collectors.toList());
    }

    public Ex4FBPost getPost (int id){
        Iterator<Ex4FBPost> it = this.posts.iterator();
        // if (!it.hasNext())
        Ex4FBPost f;
        boolean enc = false;
        while ( it.hasNext() && enc == false)
        {
            f = it.next();
            if (f.getId() == id)
                enc = true;
        }
        return (f);
    }

}
