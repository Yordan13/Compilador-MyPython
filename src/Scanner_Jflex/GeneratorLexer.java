package Scanner_Jflex;
import FilesScanner.ManagerFile;
import java.io.File;

public class GeneratorLexer {
    private String _Path;

    public GeneratorLexer(String _Path) {
        this._Path = _Path;
    }
    public void createlexer(){
        ManagerFile MFile=new ManagerFile();
        File file=MFile.openFile(_Path);
        jflex.Main.generate(file);
    }
}
