package org.antop.billiardslove.jpa.convertor;

import org.antop.billiardslove.core.GameResultStatus;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class GameResultStatusConverter implements AttributeConverter<GameResultStatus, String> {
    @Override
    public String convertToDatabaseColumn(GameResultStatus attribute) {
        if (attribute == null) return GameResultStatus.NONE.getStatus();
        return attribute.getStatus();
    }

    @Override
    public GameResultStatus convertToEntityAttribute(String dbData) {
        return GameResultStatus.of(dbData);
    }
}
