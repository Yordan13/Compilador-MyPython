
package scanner;

public abstract class Token {
    private String _Value;
    private int _LineNumber;

    public Token(String _Value, int _LineNumber) {
        this._Value = _Value;
        this._LineNumber = _LineNumber;
    }
}
