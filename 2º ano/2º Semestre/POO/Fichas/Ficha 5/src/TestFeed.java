import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class TestFeed
{

    private FBFeed feed = new FBFeed();

    public TestFeed()
    {
        Ex4FBPost post0 = new Ex4FBPost(0, "User 1", LocalDateTime.of(2018,3,10,10,30,0), "Teste 1", 0, new ArrayList<>());
        Ex4FBPost post1 = new Ex4FBPost(1, "User 1", LocalDateTime.of(2018,3,12,15,20,0), "Teste 2", 0, new ArrayList<>());
        Ex4FBPost post2 = new Ex4FBPost(2, "User 2", LocalDateTime.now(), "Teste 3", 0, new ArrayList<>());
        Ex4FBPost post3 = new Ex4FBPost(3, "User 3", LocalDateTime.now(), "Teste 4", 0, new ArrayList<>());
        Ex4FBPost post4 = new Ex4FBPost(4, "User 4", LocalDateTime.now(), "Teste 5", 0, new ArrayList<>());

        List<Ex4FBPost> tp = new ArrayList<>();
        tp.add(post0);
        tp.add(post1);
        tp.add(post2);
        tp.add(post3);
        tp.add(post4);
        feed.setPosts(tp);
    }



    @Test
    public void testNrPosts() {
        int np = feed.nrPosts("User 1");
        assertEquals(np,2);
    }

    @Test
    public void testPostsOf() {
        List<Ex4FBPost> posts = feed.postsOf("User 2");
        assertNotNull(posts);
        assertEquals(posts.size(),1);
        FBPost p = feed.postsOf("User 2").get(0);
        assertNotNull(p);
        assertEquals("User 2",p.getUsername());
    }

    @Test
    public void testGetPost() {
        Ex4FBPost p = feed.getPost(3);
        assertEquals(p.getUsername(),"User 3");
    }

    @Test
    public void testComment() {
        Ex4FBPost p = feed.getPost(3);
        feed.comment(p, "Primeiro comentario");
        assertTrue(p.getComentarios().size() == 1);
        assertEquals(p.getComentarios().get(0), "Primeiro comentario");
    }

    @Test
    public void testLike() {
        Ex4FBPost p = feed.getPost(3);
        feed.like(p);
        feed.like(p.getId());
        assertTrue(p.getLikes() == 2);
    }


    @Test
    public void testPostsOfDate() {
        List<Ex4FBPost> posts = feed.postsOf("User 1", LocalDateTime.of(2018,3,11,0,0,0),LocalDateTime.of(2018,3,15,0,0,0));
        assertEquals(posts.size(),1);
    }

    @Test
    public void testTop5() {
        List<Integer> l = feed.top5Comments();
        assertTrue(l.size() == 5);
    }

    @Test
    public void testeClasse() {
        Ex4FBPost p1 = new Ex4FBPost();
        Ex4FBPost p2 = new Ex4FBPost(p1);
        assertEquals(p1,p2);
        p2.setData(LocalDateTime.of(2017,1,1,0,0,0));
        assertFalse(p1.equals(p2));
    }
}