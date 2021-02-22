import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class TesteFBFeed
{
    public static void main(String[] args) {
        Ex4FBPost post0 = new Ex4FBPost(0, "User 1", LocalDateTime.of(2018,3,10,10,30,0), "Teste 1", 0, new ArrayList<>());
        Ex4FBPost post1 = new Ex4FBPost(1, "User 1", LocalDateTime.of(2018,3,12,15,20,0), "Teste 2", 0, new ArrayList<>());
        Ex4FBPost post2 = new Ex4FBPost(2, "User 2", LocalDateTime.now(), "Teste 3", 0, new ArrayList<>());
        Ex4FBPost post3 = new Ex4FBPost(3, "User 3", LocalDateTime.now(), "Teste 4", 0, new ArrayList<>());
        Ex4FBPost post4 = new Ex4FBPost(4, "User 4", LocalDateTime.now(), "Teste 5", 0, new ArrayList<>());

        FBFeed feed = new FBFeed();
        List<Ex4FBPost> tp = new ArrayList<>();
        tp.add(post0);
        tp.add(post1);
        tp.add(post2);
        tp.add(post3);
        tp.add(post4);
        feed.setPosts(tp);

        int np = feed.nrPosts("User 1");
        if(np==2) {
            System.out.println("NR posts ok");
        } else {
            System.out.println("Erro em NR posts");
        }

        Ex4FBPost p = feed.postsOf("User 2").get(0);
        if(p.getPost().equals("Teste 3")) {
            System.out.println("postsOf ok");
        } else {
            System.out.println("Erro em postsOf");
        }


        p = feed.getPost(3);
        if(p.getUsername().equals("User 3")) {
            System.out.println("getPost ok");
        } else {
            System.out.println("Erro em getPost");
        }

        feed.comment(p, "Primeiro comentario");
        if(p.getComentarios().get(0).equals("Primeiro comentario")) {
            System.out.println("comment ok");
        } else {
            System.out.println("Erro em comment");
        }

        feed.like(p);
        feed.like(p.getId());
        if(p.getLikes()==2) {
            System.out.println("like ok");
        } else {
            System.out.println("Erro em like");
        }

        List<Ex4FBPost> posts = feed.postsOf("User 1", LocalDateTime.of(2018,3,11,0,0,0),LocalDateTime.of(2018,3,15,0,0,0));
        if(posts.size()==1) {
            System.out.println("postsOf ok");
        } else {
            System.out.println("Erro em postsOf");
        }


        List<Integer> l = feed.top5Comments();
        if(l.size()==5) {
            System.out.println("Top5 ok");
        } else {
            System.out.println("Erro em Top5");
        }

        System.out.println("-- Post 3 --");
        System.out.println(p.toString());
    }
}
