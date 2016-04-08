
package FilesScanner;

import java.io.File;


public class  ManagerFile {

    public ManagerFile() {
    }
    public File openFile(String pPath){
        return new File(pPath);
    }
}
