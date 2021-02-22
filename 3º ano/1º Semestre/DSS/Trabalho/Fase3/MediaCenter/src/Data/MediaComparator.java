package Data;

import Business.Gestor_Media.Media;
import java.util.Comparator;

public class MediaComparator  implements Comparator<Media> {
    public int compare(Media m1, Media m2) {
        return m1.getNomeFicheiro().compareTo(m2.getNomeFicheiro());
    }
}